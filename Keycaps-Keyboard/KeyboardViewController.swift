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
    @IBOutlet weak var shiftButton: UIButton!
    @IBOutlet weak var numAlphaKey: UIButton!
    
    let colorDictionary = KeycapColors.getDictionary()
    var capsLockOn      = false
    var defaultKeysOn   = true
    
    let defaultKeys = ["0": "q", "1": "w", "2": "e", "3": "r", "4": "t", "5": "y", "6": "u", "7": "i",
                       "8": "o", "9": "p", "10": "a", "11": "s", "12": "d", "13": "f", "14": "g",
                       "15": "h", "16": "j", "17": "k", "18": "l", "19": "z", "20": "x", "21": "c",
                       "22": "v", "23": "b", "24": "n", "25": "m"]
    
    let numberKeys = ["0": "1", "1": "2", "2": "3", "3": "4", "4": "5", "5": "6", "6": "7", "7": "8",
                      "8": "9", "9": "0", "10": "-", "11": "/", "12": ":", "13": ";", "14": "(",
                       "15": ")", "16": "$", "17": "@", "18": "\"", "19": ".", "20": ",", "21": "?",
                       "22": "!", "23": "\'", "24": "+", "25": "*"]
    
    //    let specialCharacterKeys = ["": ""]
    
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
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(buttons: buttonCollection)
        updateShift(button: shiftButton)
        
    }
    
    func changeCaps(buttons:  [UIButton]!) {
        for button in buttonCollection {
            let buttonTitle = button.titleLabel!.text
            if capsLockOn {
                let text = buttonTitle!.uppercased()
                button.setTitle("\(text)", for: .normal)
            } else {
                let text = buttonTitle!.lowercased()
                button.setTitle("\(text)", for: .normal)
            }
        }
    }
    
    func updateShift(button: UIButton) -> Void {
        if capsLockOn {
            button.setTitleColor(.green, for: .normal)
        } else {
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBAction func switchKeys(_ sender: UIButton) {
        defaultKeysOn = !defaultKeysOn
        
        if defaultKeysOn {
            for (index, button) in buttonCollection.enumerated() {
               let keyCharacter = numberKeys["\(index)"]
                button.setTitle(keyCharacter, for: .normal)
            }

            shiftButton.isEnabled = false
            numAlphaKey.setTitle("abc", for: .normal)

            shiftButton.backgroundColor = UIColor.clear
            shiftButton.setTitleColor(UIColor.clear, for: .normal)
            shiftButton.layer.borderColor = UIColor.clear.cgColor
        } else {
            for (index, button) in buttonCollection.enumerated() {
                let keyCharacter = defaultKeys["\(index)"]
                button.setTitle(keyCharacter, for: .normal)
            }
            
            shiftButton.isEnabled = true
            numAlphaKey.setTitle("123", for: .normal)

            styleLegendColor(for: shiftButton)
            styleKeycap(for: shiftButton)
            styleBorderColor(for: shiftButton)
        }
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
        styleBorderColor(for: button)
        styleShowBorders(for: button)
        styleRoundedCorners(for: button)
    }
    
    func styleKeycap(for button: UIButton) -> Void {
        styleLegendColor(for: button)
        styleKeycapColor(for: button)
    }
    
    func styleModifiers(for button: UIButton) -> Void {
        styleLegendColor(for: button)
        styleModiferKeycapColor(for: button)
    }
    
    func styleSpacebar() -> Void {
        styleLegendColor(for: spacebarButton)
        styleSpacebarKeycapColor()
        styleSpacebarText()
    }
    
    func styleBackground() {
        if let colorString = KeycapSettings.getBackgroundColor() as? String {
            boardBackground.backgroundColor = colorDictionary[colorString]
        } else {
            boardBackground.backgroundColor = UIColor.lightGray
        }
    }
    
    func styleBorderColor(for button: UIButton) {
        if let colorString = KeycapSettings.getBorderColor() as? String {
            button.layer.borderColor = colorDictionary[colorString]!.cgColor
        } else {
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func styleKeycapColor(for button: UIButton) {
        if let colorString = KeycapSettings.getKeycapColor() as? String {
            button.backgroundColor = colorDictionary[colorString]
        } else {
            button.backgroundColor = UIColor.darkGray
        }
    }
    
    func styleLegendFont(for button: UIButton) -> Void {
        if let textSize = KeycapSettings.getShowLargeText() as? Int {
            button.titleLabel!.font = UIFont(name: "Helvetica Neue", size: CGFloat(textSize))
        }
    }
    
    
    func styleLegendColor(for button: UIButton) {
        if let colorString = KeycapSettings.getLegendColor() as? String {
            button.setTitleColor(colorDictionary[colorString], for: .normal)
        } else {
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func styleModiferKeycapColor(for button: UIButton) {
        if let colorString = KeycapSettings.getModifierColor() as? String {
            button.backgroundColor = colorDictionary[colorString]
        } else {
            button.backgroundColor = UIColor.darkGray
        }
    }
    
    func styleRoundedCorners(for button: UIButton) {
        if let roundCorners = KeycapSettings.getShowRoundedCorners() as? Int {
            if roundCorners == 1 {
                button.layer.cornerRadius = 10
            } else {
                button.layer.cornerRadius = 0
            }
        }
    }
    
    func styleShowBorders(for button: UIButton)  {
        if let showBorders = KeycapSettings.getShowBorder() as? Int {
            if showBorders == 1 {
                button.layer.borderWidth = 2
            } else {
                button.layer.borderWidth = 0
            }
        }
    }
    
    func styleSpacebarKeycapColor() {
        if let colorString = KeycapSettings.getSpaceBarColor() as? String {
            spacebarButton.backgroundColor = colorDictionary[colorString]
        } else {
            spacebarButton.backgroundColor = UIColor.darkGray
        }
    }
    
    func styleSpacebarText() {
        if let spacebarText = KeycapSettings.getShowSpaceBarText() as? Int {
            spacebarButton.setTitle("space", for: .normal)
            if spacebarText == 0 {
                spacebarButton.setTitleColor(.clear, for: .normal)
            } else {
                if let colorString = KeycapSettings.getLegendColor() as? String {
                    spacebarButton.setTitleColor(colorDictionary[colorString], for: .normal)
                }
            }
        }
    }


    
}
