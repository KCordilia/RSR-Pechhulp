//
//  PopupView.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 31/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class PopupView: UIView {

    private let viewModel: PopupViewModel
    weak var delegate: PopupViewDelegate?

    init(viewModel: MapPopupViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        configurePopupBox()
        configureCancelButton()
        configureTitleLabel()
        configureMessageLabel()
        configureCallButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("popupview deinitialized")
    }

    let cancelButton = UIButton()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let callButton = UIButton()
    let popupBox = UIView()


    func setupViews(view: UIView) {
        popupBox.addSubview(cancelButton)
        popupBox.addSubview(titleLabel)
        popupBox.addSubview(messageLabel)
        popupBox.addSubview(callButton)
        view.addSubview(popupBox)

        NSLayoutConstraint.activate([
            popupBox.heightAnchor.constraint(equalToConstant: 250),
            popupBox.widthAnchor.constraint(equalToConstant: 300),
            popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            cancelButton.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 0),
            cancelButton.leadingAnchor.constraint(equalTo: popupBox.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 25),

            titleLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 30),

            messageLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: popupBox.centerYAnchor),
            messageLabel.widthAnchor.constraint(equalTo: popupBox.widthAnchor),

            callButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor),
            callButton.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: -20),
            callButton.widthAnchor.constraint(equalTo: popupBox.widthAnchor, constant: -40)
        ])
    }

    @objc func callRsrNowButton() {
        makePhoneCall(to: "+319007788990")
    }

    // Creates the actionsheet to be able to call the given number
    func makePhoneCall(to phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }

    @objc func cancelAction() {
        UIView.transition(with: popupBox, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popupBox.isHidden = true
        })
        
        delegate?.unhideCalloutView()
    }

    func configurePopupBox() {
        popupBox.translatesAutoresizingMaskIntoConstraints = false
        popupBox.isHidden = true
        popupBox.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.8392156863, blue: 0, alpha: 0.7075395976)
    }

    func configureCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setBackgroundImage(UIImage(named: viewModel.cancelButtonImageName), for: .normal)
        cancelButton.setTitle(self.viewModel.cancelButtonTitle, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }

    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = viewModel.titleLabel
    }

    func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .white
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.text = viewModel.messageLabel
        messageLabel.numberOfLines = 2
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
    }

    func configureCallButton() {
        let iconImage = UIImage(named: viewModel.callButtonIconName)

        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.setTitle(viewModel.callButtonTitle, for: .normal)
        callButton.titleLabel?.textAlignment = .center
        callButton.layer.cornerRadius = 10
        callButton.setBackgroundImage(UIImage(named: viewModel.callButtonImageName), for: .normal)
        callButton.setImage(iconImage, for: .normal)
        callButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        callButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        callButton.addTarget(self, action: #selector(callRsrNowButton), for: .touchUpInside)
    }
}


