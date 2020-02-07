//
//  AboutViewModel.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 06/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

protocol AboutViewModel {
    var hyperLinkPath: String { get }
    var hyperLinkRange: String { get }
}

struct AboutVCViewModel: AboutViewModel {
    var hyperLinkPath = "https://www.rsr.nl/"
    var hyperLinkRange = "www.rsr.nl"
}
