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
    
    static let backgroundColorKey: String = "fontFamily"
    static let borderColorKey:     String = "borderColor"
    static let borderSizeKey:      String = "borderSize"
    static let borderRadiusKey:    String = "borderRadius"
    static let fontFamilyKey:      String = "fontFamily"
    static let fontSizeKey:        String = "fontSize"
    static let keycapColorKey:     String = "keycapColor"
    static let legendColorKey:     String = "legendColor"
    static let modifiersColorKey:  String = "modifiersColor"
    static let spaceBarColorKey:   String = "spaceBarColor"
    static let spaceBarTextKey:    String = "spaceBarText"
    
    static func setBackground(colorString: String) -> Void {
        if let nsColorString: NSString = colorString as NSString! {
         set(key: backgroundColorKey, to: nsColorString)
        }
    }
    
    static func getBackgroundColor() -> Any? {
        return get(valueFor: backgroundColorKey)
    }
    
    static func setBorder(colorString: String) -> Void {
        if let nsColorString: NSString = colorString as NSString! {
            set(key: borderColorKey, to: nsColorString)
        }
    }
    
    static func getBorderColor() -> Any? {
        return get(valueFor: borderColorKey)
    }
    
    static func setBorder(size: Int) -> Void {
        set(key: borderSizeKey, to: size)
    }
    
    static func getBorderSize() -> Int {
        return get(valueFor: borderSizeKey) as! Int
    }
    
    static func setBorder(radius: Int) -> Void {
        set(key: borderRadiusKey, to: radius)
    }
    
    static func getBorderRadius() -> Int {
        return get(valueFor: borderRadiusKey) as! Int
    }
    
    static func setFont(family: String) -> Void {
        set(key: fontFamilyKey, to: family)
    }
    
    static func getFontFamily() -> String {
        return get(valueFor: fontFamilyKey) as! String
    }
    
    static func setFont(size: Int) -> Void {
        set(key: fontSizeKey, to: size)
    }
    
    static func getFontSize() -> Int {
        return get(valueFor: fontSizeKey) as! Int
    }
    
    static func setKeycap(colorString: String) -> Void {
        if let nsColorString: NSString = colorString as NSString! {
            set(key: keycapColorKey, to: nsColorString)
        }
    }
    
    static func getKeycapColor() -> Any? {
        return get(valueFor: keycapColorKey)
    }
    
    static func setLegend(colorString: String) -> Void {
        if let nsColorString: NSString = colorString as NSString! {
            set(key: legendColorKey, to: nsColorString)
        }
    }
    
    static func getLegendColor() -> Any? {
        return get(valueFor: legendColorKey)
    }
    
    static func setModifier(colorString: String) -> Void {
        if let nsColorString: NSString = colorString as NSString! {
            set(key: modifiersColorKey, to: nsColorString)
        }
    }
    
    static func getModifierColor() -> Any? {
       return get(valueFor: modifiersColorKey)
    }
    
    static func setSpacebar(colorString: String) -> Void {
        if let nsColorString: NSString = colorString as NSString! {
            set(key: spaceBarColorKey, to: nsColorString)
        }
    }
    
    static func getSpaceBarColor() -> Any? {
        return get(valueFor: spaceBarColorKey)
    }
    
    
    static func toggleShowSpaceBarText(to: Bool) -> Void {
        set(key: spaceBarTextKey, to: true)
    }
    
    static func getShowSpaceBarText() -> Bool {
        return get(valueFor: spaceBarTextKey) as! Bool
    }
    
    ////
    //  Swift currently does not have priavve functions treat these as if they are private
    ////
    static func set(key: String, to value: Any) -> Void {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(valueFor key: String) -> Any {
        return UserDefaults.standard.object(forKey: key) ?? (Any).self
    }
}
