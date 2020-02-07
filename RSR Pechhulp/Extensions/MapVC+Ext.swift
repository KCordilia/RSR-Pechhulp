//
//  MapVC+Ext.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 29/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension MapVC: PopupViewDelegate {
    func unhideCalloutView() {
        locationCalloutView.isHidden = false
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
        let annotationView = MapAnnotationView(annotation: annotation, viewModel: MapAnnotationViewModel())
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


