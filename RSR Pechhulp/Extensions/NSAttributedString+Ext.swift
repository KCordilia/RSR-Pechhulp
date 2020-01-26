//
//  NSAttributedString+Ext.swift
//  RSR Pechhulp
//
//  Created by Karim Cordilia on 24/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

extension NSAttributedString {

    static func makeHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)

        return attributedString

    }
}
