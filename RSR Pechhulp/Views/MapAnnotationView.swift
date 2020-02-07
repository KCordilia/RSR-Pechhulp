//
//  MapAnnotationView.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 03/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotationView: MKAnnotationView {

    private var viewModel: AnnotationViewModel

    init(annotation: MKAnnotation, viewModel: AnnotationViewModel) {
        self.viewModel = viewModel
        super.init(annotation: annotation, reuseIdentifier: viewModel.reuseIdentifier)
        configureAnnotationView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureAnnotationView() {
        canShowCallout = false
        image = UIImage(named: viewModel.annotationImageName)
    }
}
