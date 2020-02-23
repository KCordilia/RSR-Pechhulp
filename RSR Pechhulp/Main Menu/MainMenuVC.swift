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
    let viewModel = MainMenuVCViewModel()

    @IBOutlet weak var aboutButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfPrivacyConsentIsGiven()
        checkIfDeviceIsIpad()
    }

    func checkIfPrivacyConsentIsGiven() {
        if !userDefaults.bool(forKey: viewModel.userDefaultsKey) {
            showPrivacyAlert(userDefaultsKey: viewModel.userDefaultsKey)
        }
    }

    func checkIfDeviceIsIpad() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
}
