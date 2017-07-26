//
//  Settings.swift
//  Keycaps
//
//  Created by Richard Rissanen on 7/25/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import Foundation
import UIKit

struct KeycapSettings {
    // font-family
    // background-color
    // font-size
    // keycap-color
    // legend-color
    // radius-level
    // border-thickness
    // border-color
    
    ////
    // Extras
    ////
    // Modifier Keys only changes
    // spacebar only changes
    // AEK ii font
    // flat vs button
    
    let backgroundColorKey: String = "fontFamily"
    let borderColorKey:     String = "borderColor"
    let borderSizeKey:      String = "borderSize"
    let fontFamilyKey:      String = "fontFamily"
    let fontSizeKey:        String = "fontSize"
    let keycapColorKey:     String = "keycapColor"
    let legendColorKey:     String = "legendColor"
    let radiusLevelKey:     String = "radiusLevel"
    
    func setBackgroundColor(color: UIColor) -> Void {
        set(key: backgroundColorKey, to: color)
    }
    
    func getBackgroundColor(key: String) -> UIColor {
        return get(valueFor: fontFamilyKey) as! UIColor
    }
    
    func setFontFamily(forLabel font: String) -> Void {
        set(key: fontFamilyKey, to: font)
    }
    
    func getFontFamily(key: String) -> String {
        return get(valueFor: fontFamilyKey) as! String
    }
    
    ////
    //  Swift currently does not have priavve functions treat these as if they are private
    ////
    func set(key: String, to value: Any) -> Void {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func get(valueFor key: String) -> Any {
        return UserDefaults.standard.object(forKey: key) ?? (Any).self
    }
}
