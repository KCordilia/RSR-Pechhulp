//
//  MainMenuVC.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 22/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    let userDefaults = UserDefaults.standard

    @IBOutlet weak var aboutButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfPrivacyConsentIsGiven()
        checkIfDeviceIsIpad()
    }

    func checkIfPrivacyConsentIsGiven() {
        if !userDefaults.bool(forKey: "PrivacyConsent") {
            showPrivacyAlert()
        }
    }

    func checkIfDeviceIsIpad() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    func showPrivacyAlert() {
        let alert = UIAlertController(title: nil, message: "Om gebruik te maken van deze app dient u het privacybeleid te accepteren", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accepteren", style: .default, handler: { (action) in
            // save in user defaults
            self.userDefaults.set(true, forKey: "PrivacyConsent")
        }))

        alert.addAction(UIAlertAction(title: "Ga naar privacybeleid", style: .default, handler: { (action) in
            // open link in browser
            if let url = URL(string: "https://www.rsr.nl/index.php?page=privacy-wetgeving") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }


}
