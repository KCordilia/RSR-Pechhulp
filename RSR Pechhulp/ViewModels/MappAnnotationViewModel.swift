//
//  MappAnnotationViewModel.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 04/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

protocol AnnotationViewModel {
    var reuseIdentifier: String { get }
    var annotationImageName: String { get }
}

struct MapAnnotationViewModel: AnnotationViewModel {

    var reuseIdentifier = "AnnotationIdentifier"
    var annotationImageName = "marker"
}
