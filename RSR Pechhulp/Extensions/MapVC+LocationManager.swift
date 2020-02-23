//
//  MapVC+LocationManager.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 01/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension MapVC {

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
    // This checks if location servies are enabled
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationServicesAuthorization()
        } else {
            showAlert()
        }
    }

    // Gets the address information by using reverse geolocation
    func reverseGeoLocate() {
        if let location = locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) {
                [weak self] (placemarks, error) in

                guard let self = self else { return }

                if let _ = error {
                    return
                }

                guard let placemark = placemarks?.first else {
                    return
                }

                let streetName = placemark.thoroughfare ?? self.viewModel.noAddressFoundLabel
                let streetNumber = placemark.subThoroughfare ?? self.viewModel.emptyString
                let zipCode = placemark.postalCode ?? self.viewModel.emptyString
                let city = placemark.locality ?? self.viewModel.emptyString

                DispatchQueue.main.async {
                    self.addressLabel.text = "\(streetName) \(streetNumber), \(zipCode), \(city)"
                }
            }
        }
    }

}
