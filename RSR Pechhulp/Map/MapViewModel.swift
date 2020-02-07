//
//  MapViewModel.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 03/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

protocol MapViewModel {
    var networkMonitorQueueLabel: String { get }
    var noAddressFoundLabel: String { get }
    var emptyString: String { get }
    var regionInMeters: Double { get }
    var layoutMargins: CGFloat { get }
}

struct MapVCViewModel: MapViewModel {
    var networkMonitorQueueLabel: String = "NetworkMonitor"
    var noAddressFoundLabel: String = "Geen adres gevonden op uw locatie"
    var emptyString: String = ""
    var regionInMeters: Double = 700
    var layoutMargins: CGFloat = -100
}
