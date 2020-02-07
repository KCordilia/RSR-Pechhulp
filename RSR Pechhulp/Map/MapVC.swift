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
import Network

class MapVC: UIViewController {

    var viewModel = MapVCViewModel()

    @IBOutlet var locationCalloutView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!

    let networkMonitor = NWPathMonitor()

    var networkStatus: NetworkStatus = .notDetermined
    let popupView = PopupView(viewModel: MapPopupViewModel())

    let locationManager = CLLocationManager()
    var regionMeters: Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        configureMapView()
        configureNetworkMonitor()
        popupView.setupViews(view: view)
        popupView.delegate = self
    }

    // Shows custom alert and removes callout view
    @IBAction func callRsrNumber(_ sender: Any) {
        UIView.transition(with: popupView.popupBox, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popupView.popupBox.isHidden = false
        })

        locationCalloutView.isHidden = true
    }


    // Pops off the current viewcontroller using the custom back button
    @IBAction func backToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

// Location Manager setup
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }


// Configuring mapView settings
    func configureMapView() {
        mapView.layoutMargins.bottom = viewModel.layoutMargins
        mapView.delegate = self
        mapView.userLocation.title = viewModel.emptyString
    }

// Centers the mapview on the user's current location
    func centerViewOnUserLocation() {
        regionMeters = viewModel.regionInMeters
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }

// Setting up the network monitor to check if there is an internet connection
    func configureNetworkMonitor() {
        let queue = DispatchQueue(label: viewModel.networkMonitorQueueLabel)

        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.networkStatus = .connected
            } else {
                self.networkStatus = .notConnected
                DispatchQueue.main.async {
                    AlertManager(owner: self).showInternetAccessAlert(networkStatus: self.networkStatus) {
                        self.centerViewOnUserLocation()
                    }
                }
            }
        }
        networkMonitor.start(queue: queue)
    }
}
