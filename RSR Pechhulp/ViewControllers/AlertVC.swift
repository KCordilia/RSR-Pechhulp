//
//  AlertVC.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 25/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {

    // Creates the actionsheet to be able to call the given number
    func makePhoneCall(to phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }

    // Action to call
    @IBAction func callRsrNowButton(_ sender: Any) {
        makePhoneCall(to: "+319007788990")
    }

    // Dismisses the alert
    @IBAction func dimissAlert(_ sender: Any) {
        dismiss(animated: true)
    }
}
