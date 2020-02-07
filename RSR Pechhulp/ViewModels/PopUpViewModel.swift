//
//  PopUpViewModel.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 04/02/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

protocol PopupViewModel {

    var cancelButtonImageName: String { get }
    var cancelButtonTitle: String { get}
    var titleLabel: String { get }
    var messageLabel: String { get }
    var callButtonIconName: String { get }
    var callButtonImageName: String { get }
    var callButtonTitle: String { get }

}

struct MapPopupViewModel: PopupViewModel {

    var cancelButtonImageName: String = "annuleren_normal"
    var cancelButtonTitle: String = "Annuleren"
    var titleLabel: String = "Belkosten"
    var messageLabel: String = "Voor dit nummer betaalt u uw gebruikelijke belkosten."
    var callButtonIconName: String = "ic_call"
    var callButtonImageName: String = "btn_normal"
    var callButtonTitle: String = "Bel nu"
}


