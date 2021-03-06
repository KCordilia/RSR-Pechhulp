//
//  AboutVC.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 24/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    private let viewModel = AboutVCViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        createHyperLink()
    }

    // Creates a hyperlink to open in safari
    func createHyperLink() {
        let path = viewModel.hyperLinkPath
        guard let text = textView.text else { return }
        let attributedString = NSMutableAttributedString.makeHyperlink(for: path, in: text, as: viewModel.hyperLinkRange)
        let font = textView.font
        textView.attributedText = attributedString
        textView.font = font
        textView.textColor = .systemGray
    }

    // Pops off the current viewcontroller using the custom back button
    @IBAction func backToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
