//
//  AlertManager.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 25/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

protocol AlertManager {

    // Shows alert if location services are turned of or denied
    func showAlert()

    // Shows alert if location services are restricted e.g. parental controls
    func showRestrictedAlert() 


    // Shows alert when network is not available otherwise center on user's location
    func showInternetAccessAlert(networkStatus: NetworkStatus, onConnected: (() -> ())?) 

    func showPrivacyAlert(userDefaultsKey: String) 
}
