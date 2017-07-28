//
//  KeyboardViewController.swift
//  Keycaps-Keyboard
//
//  Created by Richard Rissanen on 7/25/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var nextKeyboardButton: UIButton!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var modifierCollection: [UIButton]!
    @IBOutlet var boardBackground: UIView!
    @IBOutlet weak var spacebarButton: UIButton!
    
    let colorDictionary = KeycapColors.getDictionary()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here

        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        for button in buttonCollection {
            styleKeycap(for: button)
            styleLegendFont(for: button)
        }
        
        for button in modifierCollection { styleModifiers(for: button) }
        
        let allButtons: [UIButton] = buttonCollection + modifierCollection
        for button in allButtons { styleBorders(for: button) }
        
        styleBackground()
        styleSpacebar()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
        
        print("memory warning!")
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    func styleBorders(for button: UIButton) -> Void {
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        
        if let colorString = KeycapSettings.getBorderColor() as? String {
            button.layer.borderColor = colorDictionary[colorString]!.cgColor
        } else {
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        

    }
    
    func styleKeycap(for button: UIButton) -> Void {
        
        if let colorString = KeycapSettings.getLegendColor() as? String {
            button.setTitleColor(colorDictionary[colorString], for: .normal)
        } else {
            button.setTitleColor(UIColor.white, for: .normal)
        }

        if let colorString = KeycapSettings.getKeycapColor() as? String {
            button.backgroundColor = colorDictionary[colorString]
        } else {
            button.backgroundColor = UIColor.darkGray
        }
        
    }
    
    func styleModifiers(for button: UIButton) -> Void {
        
        if let colorString = KeycapSettings.getLegendColor() as? String {
            button.setTitleColor(colorDictionary[colorString], for: .normal)
        } else {
            button.setTitleColor(UIColor.white, for: .normal)
        }
        
        if let colorString = KeycapSettings.getModifierColor() as? String {
            button.backgroundColor = colorDictionary[colorString]
        } else {
            button.backgroundColor = UIColor.darkGray
        }
        
    }
    
    func styleSpacebar() -> Void {
        
        if let colorString = KeycapSettings.getLegendColor() as? String {
            spacebarButton.setTitleColor(colorDictionary[colorString], for: .normal)
        } else {
            spacebarButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        if let colorString = KeycapSettings.getSpaceBarColor() as? String {
            spacebarButton.backgroundColor = colorDictionary[colorString]
        } else {
            spacebarButton.backgroundColor = UIColor.darkGray
        }
        
        if let spacebarText = KeycapSettings.getShowSpaceBarText() as? Bool {
            spacebarButton.setTitle("\(spacebarText)", for: .normal)
            if !spacebarText { spacebarButton.setTitleColor(.clear, for: .normal)}
        }
        
    }
    
    
    func styleLegendFont(for button: UIButton) -> Void {
        button.titleLabel!.font = UIFont(name: "Marker Felt", size: 20)
    }
    
    func styleBackground() -> Void {
        if let colorString = KeycapSettings.getBackgroundColor() as? String {
            boardBackground.backgroundColor = colorDictionary[colorString]
        } else {
            boardBackground.backgroundColor = UIColor.lightGray
        }
    }


    
}
