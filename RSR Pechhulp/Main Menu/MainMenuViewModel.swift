//
//  MainMenuViewModel.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 05/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

protocol MainMenuViewModel {
    var userDefaultsKey: String { get }
}

struct MainMenuVCViewModel: MainMenuViewModel {
    var userDefaultsKey: String = "PrivacyConsent"
}
