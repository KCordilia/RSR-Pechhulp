//
//  AlertManager.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 25/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

struct AlertManager {

    private let owner: UIViewController

    init(owner: UIViewController) {
        self.owner = owner
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

        owner.present(alert, animated: true)
    }

    // Shows alert if location services are restricted e.g. parental controls
    func showRestrictedAlert() {
        let alert = UIAlertController(title: "Restricted Access", message: "Location Services are restricted", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)

        alert.addAction(okAction)

        owner.present(alert, animated: true)
    }


    // Shows alert when network is not available otherwise center on user's location
    func showInternetAccessAlert(networkStatus: NetworkStatus, onConnected: (() -> ())?) {
        if networkStatus == .notConnected {
            let alert = UIAlertController(title: "Internet error", message: "Unable to locate your address. Please check your internet connection", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let retryAction = UIAlertAction(title: "Retry", style: .default) {
                action in
                if networkStatus == .notConnected {
                    self.showInternetAccessAlert(networkStatus: networkStatus, onConnected: nil)
                } else {
                    onConnected?()
                }
            }

            alert.addAction(cancelAction)
            alert.addAction(retryAction)
            owner.present(alert, animated: true, completion: nil)
        }
    }

    func showPrivacyAlert(userDefaultsKey: String) {
        let userDefaults = UserDefaults.standard
        let alert = UIAlertController(title: nil, message: "Om gebruik te maken van deze app dient u het privacybeleid te accepteren", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accepteren", style: .default, handler: { (action) in
            userDefaults.set(true, forKey: userDefaultsKey)
        }))

        alert.addAction(UIAlertAction(title: "Ga naar privacybeleid", style: .default, handler: { (action) in
            if let url = URL(string: "https://www.rsr.nl/index.php?page=privacy-wetgeving") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))

        owner.present(alert, animated: true, completion: nil)
    }
}
