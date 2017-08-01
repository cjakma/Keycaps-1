//
//  KeycapColors.swift
//  Keycaps
//
//  Created by Richard Rissanen on 7/26/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import Foundation
import UIKit

struct KeycapColors {
    
    static let black         = UIColor.black
    static let blue          = UIColor(red: 25/255, green: 117/255, blue: 196/255, alpha: 1.0)
    static let bluebird      = UIColor(red: 45/255, green: 150/255, blue: 212/255, alpha: 1.0)
    static let bubblegum     = UIColor(red: 244/255, green: 175/255, blue: 244/255, alpha: 1.0)
    static let chocolate     = UIColor(red: 143/255, green: 72/255, blue: 20/255, alpha: 1.0)
    static let chocolateDark = UIColor(red: 76/255, green: 38/255, blue: 11/255, alpha: 1.0)
    static let cyan          = UIColor(red: 45/255, green: 212/255, blue: 191/255, alpha: 1.0)
    static let forestGreen   = UIColor(red: 38/255, green: 78/255, blue: 53/255, alpha: 1.0)
    static let grayDark      = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1.0)
    static let grayMedium    = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    static let grayLight     = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1.0)
    static let indigo        = UIColor(red: 73/255, green: 15/255, blue: 115/255, alpha: 1.0)
    static let lime          = UIColor(red: 150/255, green: 212/255, blue: 45/255, alpha: 1.0)
    static let orange        = UIColor(red: 212/255, green: 107/255, blue: 45/255, alpha: 1.0)
    static let magenta       = UIColor(red: 191/255, green: 45/255, blue: 212/255, alpha: 1.0)
    static let pink          = UIColor(red: 212/255, green: 45/255, blue: 150/255, alpha: 1.0)
    static let purple        = UIColor.purple
    static let royalty       = UIColor(red: 107/255, green: 45/255, blue: 212/255, alpha: 1.0)
    static let strawberry    = UIColor(red: 212/255, green: 45/255, blue: 66/255, alpha: 1.0)
    static let torinoRed     = UIColor(red: 219/255, green: 28/255, blue: 34/255, alpha: 1.0)
    static let violet        = UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1.0)
    static let white         = UIColor.white
    static let tvYellow      = UIColor(red: 247/255, green: 201/255, blue: 97/255, alpha: 1.0)

    static func getDictionary() -> [String: UIColor] {
        let colorDictionary = ["Black": UIColor.black, "Blue": blue, "Bluebird": bluebird, "Bubblegum": bubblegum, "Chocolate": chocolate, "Chocolate Dark": chocolateDark, "Cyan": cyan, "Forest Green": forestGreen, "Gray Dark": grayDark, "Gray Medium": grayMedium, "Gray light": grayLight, "Indigo": indigo, "Lime": lime, "Magenta": magenta, "Pink": pink, "Purple": purple, "Orange": orange, "Red": torinoRed, "Royalty": royalty, "Strawberry": strawberry, "Yellow": tvYellow,  "Violet": violet,  "White": UIColor.white]
                               
        return colorDictionary
    }
    
    static func getArray() -> [String] {
        return  ["Black", "Blue", "Bluebird", "Bubblegum", "Chocolate", "Chocolate Dark", "Cyan", "Forest Green", "Gray Dark", "Gray Medium", "Gray light", "Indigo", "Lime", "Magenta", "Pink", "Purple", "Orange", "Red", "Royalty", "Strawberry", "Yellow", "Violet",  "White"]
    }
}
