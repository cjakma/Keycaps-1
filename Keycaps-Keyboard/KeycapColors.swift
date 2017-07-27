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
    
    static func getDictionary() -> [String: UIColor] {
        let colorDictionary = ["Red": UIColor.red, "Orange": UIColor.orange, "Yellow": UIColor.yellow,
                               "Green": UIColor.green, "Cyan": UIColor.cyan, "Blue": UIColor.blue,
                               "Indigo": UIColor(red: 75/255, green: 0/255, blue: 130/255, alpha: 1.0),
                               "Violet": UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1.0),
                               "Purple": UIColor.purple, "Magenta": UIColor.magenta,
                               "Pink": UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1.0),
                               "Brown": UIColor.brown, "White": UIColor.white, "Gray": UIColor.gray ,
                               "Black": UIColor.black]
        return colorDictionary
    }
    
    static func getArray() -> [String] {
        return ["Red", "Orange", "Yellow", "Green", "Cyan", "Blue", "Indigo", "Violet",
                "Purple", "Magenta", "Pink", "Brown", "White", "Gray" ,"Black"]
    }
}
