//
//  KeyboardViewController.swift
//  Keycaps-Keyboard
//
//  Created by Richard Rissanen on 7/25/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import UIKit

protocol DismissViewControllerProtocol {
    func dismissViewControllerAndReloadKeyboard()
}

class KeyboardViewController: UIInputViewController, DismissViewControllerProtocol {

    @IBOutlet var buttonCollection:        [UIButton]!
    @IBOutlet var modifierCollection:      [UIButton]!
    @IBOutlet var boardBackground:         UIView!
    @IBOutlet weak var spacebarButton:     UIButton!
    @IBOutlet weak var shiftButton:        UIButton!
    @IBOutlet weak var numAlphaKey:        UIButton!
    @IBOutlet weak var backspaceButton:    UIButton!
    @IBOutlet weak var returnButton:       UIButton!
    @IBOutlet weak var settingsButton:     UIButton!
    @IBOutlet weak var nextKeyboardButton: UIButton!
    
    let colorDictionary = KeycapColors.getDictionary()
    var capsLockOn      = false
    var shiftOn         = true
    var defaultKeysOn   = true
    
    let defaultKeys = ["0": "&", "1": "\'", "2": "\"", "3": ":", "4": ";", "5": "@", "6": ".", "7": ",",
                       "8": "?", "9": "!", "10": "q", "11": "w", "12": "e", "13": "r", "14": "t", "15": "y",
                       "16": "u", "17": "i", "18": "o", "19": "p", "20": "a", "21": "s", "22": "d", "23": "f",
                       "24": "g", "25": "h", "26": "j", "27": "k", "28": "l", "29": "z", "30": "x", "31": "c",
                       "32": "v", "33": "b", "34": "n", "35": "m"]
    
    let numberKeys = ["0": "1", "1": "2", "2": "3", "3": "4", "4": "5", "5": "6", "6": "7", "7": "8",
                      "8": "9", "9": "0", "10": "[", "11": "]", "12": "{", "13": "}", "14": "(",
                      "15": ")", "16": "<", "17": ">", "18": "~", "19": "`", "20": "_", "21": "•",
                      "22": "#", "23": "€", "24": "£", "25": "$", "26": "¥", "27": "%", "28": "^",
                      "29": "\\", "30": "|", "31": "/", "32": "*", "33": "-", "34": "+", "35": "="]
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform custom UI setup here

        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

        shiftButton.setTitle("\u{2b06}", for: .normal)
        returnButton.setTitle("\u{21B5}", for: .normal)
        settingsButton.setTitle("\u{2699}", for: .normal)
        backspaceButton.setTitle("\u{232B}", for: .normal)
        nextKeyboardButton.setTitle("\u{1F310}", for: .normal)

        styleAllButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setInitialHeight() // Initial load is smooth due to this
    }
    
    
    func setInitialHeight() {
        let expandedHeight: CGFloat = 270 // fixed for all phone sizes != ideal
        
        let heightConstraint: NSLayoutConstraint =  NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: expandedHeight)
        
        self.view.addConstraint(heightConstraint)
    }
    
    func dismissViewControllerAndReloadKeyboard() {
        styleAllButtons()
        self.dismiss(animated: true, completion: nil)
    }
    
    ////
    // Typing
    ////
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        
        if shiftOn {
            (textDocumentProxy as UIKeyInput).insertText("\(string!.uppercased())")

            shiftOn = false
            
            changeCaps(buttons: buttonCollection)
            updateShift(button: shiftButton)
        } else {
            (textDocumentProxy as UIKeyInput).insertText("\(string!.lowercased())")
        }
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        checkForQuickPeriod()
        (textDocumentProxy as UIKeyInput).insertText(" ")
        checkForPunctuation()
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func shiftPressed(button: UIButton) {
        
        shiftOn = !shiftOn
        
        changeCaps(buttons: buttonCollection)
        updateShift(button: shiftButton)
    }
    
    func changeCaps(buttons:  [UIButton]!) {
        for button in buttonCollection {
            let buttonTitle = button.titleLabel!.text
            if capsLockOn || shiftOn {
                let text = buttonTitle!.uppercased()
                button.setTitle("\(text)", for: .normal)
            } else {
                let text = buttonTitle!.lowercased()
                button.setTitle("\(text)", for: .normal)
            }
        }
    }
    
    func updateShift(button: UIButton) -> Void {
        if shiftOn {
            shiftButton.setTitle("\u{2b06}", for: .normal)
        } else {
            shiftButton.setTitle("\u{21e7}", for: .normal)
        }
    }
    
    func checkForPunctuation() {
        if let precedingContext: String = self.textDocumentProxy.documentContextBeforeInput {
            
            switch String(precedingContext.characters.suffix(2)) {
            case ". ", "? ", "! ":
                shiftOn = true
                changeCaps(buttons: buttonCollection)
                updateShift(button: shiftButton)
            default:
                print("")
            }
        }
    }
    
    func checkForQuickPeriod() {
        if let precedingContext: String = self.textDocumentProxy.documentContextBeforeInput {
            if precedingContext.characters.last! == " " {
                (textDocumentProxy as UIKeyInput).deleteBackward()
                (textDocumentProxy as UIKeyInput).insertText(".")
                
                shiftOn = true
                changeCaps(buttons: buttonCollection)
                updateShift(button: shiftButton)
            }
        }
        
    }
    
    
    ////
    // Styling
    ///
    func styleAllButtons() {
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
    
    @IBAction func switchKeys(_ sender: UIButton) {
        
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
            styleModifiers(for: shiftButton)
            styleBorderColor(for: shiftButton)
        }
        
        defaultKeysOn = !defaultKeysOn
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
        
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
        
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
