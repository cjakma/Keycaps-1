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
    

    static let bluebird      = UIColor(red: 0/255, green: 211/255, blue: 230/255, alpha: 1.0)
    static let chocolate     = UIColor(red: 95/255, green: 43/255, blue: 12/255, alpha: 1.0)
    static let orange        = UIColor(red: 230/255, green: 134/255, blue: 0/255, alpha: 1.0)
    static let strawberry    = UIColor(red: 230/255, green: 0/255, blue: 96/255, alpha: 1.0)
    static let yellow        = UIColor(red: 211/255, green: 230/255, blue: 0/255, alpha: 1.0)

    static let black         = UIColor.black
    static let grayDark      = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1.0)
    static let grayMedium    = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    static let grayLight     = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1.0)
    static let white         = UIColor.white

    static func getDictionary() -> [String: UIColor] {
        let colorDictionary = ["Black": UIColor.black, "Bluebird": bluebird, "Chocolate": chocolate, "Dark Gray": grayDark, "Medium Gray": grayMedium, "Light Gray": grayLight, "Orange": orange, "Strawberry": strawberry, "Yellow": yellow,  "White": UIColor.white]
                               
        return colorDictionary
    }
    
    static func getArray() -> [String] {
        return  ["Bluebird", "Chocolate", "Orange", "Strawberry", "Yellow", "Black", "Dark Gray", "Medium Gray", "Light Gray", "White"]
    }
}
