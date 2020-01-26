//
//  AlertManager.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 25/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class AlertManager {

    // Instantiates the AlertViewController when it's called upon
    func alert() -> AlertVC {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC

        return alertVC
    }
}
