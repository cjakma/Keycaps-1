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
    ////
    // Extras
    ////
    // AEK ii font
    // flat vs button
    // Predesigned Templates
    
    let backgroundColorKey: String = "fontFamily"
    let borderColorKey:     String = "borderColor"
    let borderSizeKey:      String = "borderSize"
    let borderRadiusKey:    String = "borderRadius"
    let fontFamilyKey:      String = "fontFamily"
    let fontSizeKey:        String = "fontSize"
    let keycapColorKey:     String = "keycapColor"
    let legendColorKey:     String = "legendColor"
    let modifiersColorKey:  String = "modifiersColor"
    let spaceBarColorKey:   String = "spaceBarColor"
    let spaceBarTextKey:    String = "spaceBarText"
    
    func setBackground(color: UIColor) -> Void {
        set(key: backgroundColorKey, to: color)
    }
    
    func getBackgroundColor() -> UIColor {
        return get(valueFor: backgroundColorKey) as! UIColor
    }
    
    func setBorder(color: UIColor) -> Void {
        set(key: borderColorKey, to: color)
    }
    
    func getBorderColor() -> UIColor {
        return get(valueFor: borderColorKey) as! UIColor
    }
    
    func setBorder(size: Int) -> Void {
        set(key: borderSizeKey, to: size)
    }
    
    func getBorderColor() -> Int {
        return get(valueFor: borderSizeKey) as! Int
    }
    
    func setBorder(radius: Int) -> Void {
        set(key: borderRadiusKey, to: radius)
    }
    
    func getBorderRadius() -> Int {
        return get(valueFor: borderRadiusKey) as! Int
    }
    
    func setFont(family: String) -> Void {
        set(key: fontFamilyKey, to: family)
    }
    
    func getFontFamily() -> String {
        return get(valueFor: fontFamilyKey) as! String
    }
    
    func setFont(size: Int) -> Void {
        set(key: fontSizeKey, to: size)
    }
    
    func getFontSize() -> Int {
        return get(valueFor: fontSizeKey) as! Int
    }
    
    func setKeycap(color: UIColor) -> Void {
        set(key: keycapColorKey, to: color)
    }
    
    func getKeycapColor() -> UIColor {
        return get(valueFor: keycapColorKey) as! UIColor
    }
    
    func setLegend(color: UIColor) -> Void {
        set(key: legendColorKey, to: color)
    }
    
    func getLegendColor() -> UIColor {
        return get(valueFor: legendColorKey) as! UIColor
    }
    
    func setModifier(color: UIColor) -> Void {
        set(key: modifiersColorKey, to: color)
    }
    
    func getModifierColor() -> UIColor {
       return get(valueFor: modifiersColorKey) as! UIColor
    }
    
    func setSpacebar(color: UIColor) -> Void {
        set(key: spaceBarColorKey, to: color)
    }
    
    func getSpaceBarColor() -> UIColor {
        return get(valueFor: spaceBarColorKey) as! UIColor
    }
    
    
    func toggleShowSpaceBarText(to: Bool) -> Void {
        set(key: spaceBarTextKey, to: true)
    }
    
    func getShowSpaceBarText() -> Bool {
        return get(valueFor: spaceBarTextKey) as! Bool
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
