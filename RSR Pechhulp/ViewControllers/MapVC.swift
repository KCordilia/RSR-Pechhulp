//
//  MapVC.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 22/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SystemConfiguration

class MapVC: UIViewController {

    @IBOutlet var locationCalloutView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!

    let locationManager = CLLocationManager()
    let regionMeters: Double = 700

    let alertManager = AlertManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        configureMapView()
        showInternetAccessAlert()
    }

    // Configuring mapView settings
    func configureMapView() {
        self.overrideUserInterfaceStyle = .light
        mapView.layoutMargins.bottom = -100
        mapView.delegate = self
        mapView.userLocation.title = ""
    }

    // This checks if location servies are enabled
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationServicesAuthorization()
        } else {
            showAlert()
        }
    }

    // Centers the mapview on the user's current location
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }

    // Gets the address information by using reverse geolocation
    func reverseGeoLocate() {
        if let location = locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                guard let self = self else { return }

                if let _ = error {
                    return
                }

                guard let placemark = placemarks?.first else {

                    return
                }

                let streetName = placemark.thoroughfare ?? "Geen adres gevonden op uw locatie"
                let streetNumber = placemark.subThoroughfare ?? ""
                let zipCode = placemark.postalCode ?? ""
                let city = placemark.locality ?? ""

                DispatchQueue.main.async {
                    self.addressLabel.text = "\(streetName) \(streetNumber), \(zipCode), \(city)"
                }
            }
        }
    }


    // Location Manager setup
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    // Check the status of the authorization given by the user.
    func checkLocationServicesAuthorization() {

        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            centerViewOnUserLocation()
            reverseGeoLocate()
        case .denied:
            showAlert()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case.restricted:
            showRestrictedAlert()
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }

    // Shows alert if location services are turned of or denied
    func showAlert() {
        let alert = UIAlertController(title: "Location Permission", message: "Please authorize RSR to find your location while using the app", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL)
        }

        alert.addAction(cancelAction)
        alert.addAction(okAction)

        present(alert, animated: true)
    }

    // Shows alert if location services are restricted e.g. parental controls
    func showRestrictedAlert() {
        let alert = UIAlertController(title: "Restricted Access", message: "Location Services are restricted", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)

        alert.addAction(okAction)

        present(alert, animated: true)
    }

    // Shows custom alert
    @IBAction func callRsrNumber(_ sender: Any) {
        let alertVC = alertManager.alert()
        present(alertVC, animated: true)
    }

    // Pops off the current viewcontroller using the custom back button
    @IBAction func backToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // Checks the System if network access is available
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }

    // Shows alert when network is not available otherwise center on user's location
    func showInternetAccessAlert() {
        if !isInternetAvailable() {
            let alert = UIAlertController(title: "Internet error", message: "Unable to locate your address. Please check your internet connection", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] action in
                guard let self = self else { return }
                if !self.isInternetAvailable() {
                    self.showInternetAccessAlert()
                } else {
                    self.centerViewOnUserLocation()
                }
            }

            alert.addAction(cancelAction)
            alert.addAction(retryAction)
            present(alert, animated: true, completion: nil)
        }
    }


}

extension MapVC: CLLocationManagerDelegate {
    // If the user changed authorization, this will call the authorization check function
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServicesAuthorization()
    }
}

extension MapVC: MKMapViewDelegate {
    // Creating a custom annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        let annotationIdentifier = "AnnotationIdentifier"

        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        annotationView?.canShowCallout = false

        if let annotationView = annotationView {
            annotationView.image = UIImage(named: "marker")
        }

        return annotationView
    }

    // When the annotation is selected the custom callout will appear
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let callout = locationCalloutView {
            view.addSubview(callout)
            callout.translatesAutoresizingMaskIntoConstraints = false
            callout.layer.cornerRadius = 10
            callout.clipsToBounds = true

            NSLayoutConstraint.activate([
                callout.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                callout.widthAnchor.constraint(equalToConstant: 240),
                callout.heightAnchor.constraint(equalToConstant: 190),
                callout.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -8)
            ])

        }
    }
    // Opens the user location's callout by default
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach() { view in
            if view.annotation is MKUserLocation {
                mapView.selectAnnotation(view.annotation!, animated: true)
            }
        }
    }
}
