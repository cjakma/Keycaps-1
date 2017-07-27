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
        
        let allButtons: [UIButton] = buttonCollection + modifierCollection
        for button in allButtons { styleBorder(for: button) }
        
        styleBackground()
        
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
    
    func styleBorder(for button: UIButton) -> Void {
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 2
    }
    
    func styleKeycap(for button: UIButton) -> Void {
        
        if let colorString = KeycapSettings.getLegendColor() as? String {
            let colorDictionary = KeycapColors.getDictionary()
            
            button.setTitleColor(colorDictionary[colorString], for: .normal)
        } else {
            button.setTitleColor(UIColor.white, for: .normal)
        }

        if let colorString = KeycapSettings.getKeycapColor() as? String {
            let colorDictionary = KeycapColors.getDictionary()
            
            button.backgroundColor = colorDictionary[colorString]
        } else {
            button.backgroundColor = UIColor.darkGray
        }
        
    }
    
    func styleLegendFont(for button: UIButton) -> Void {
        button.titleLabel!.font = UIFont(name: "Marker Felt", size: 20)
    }
    
    func styleBackground() -> Void {
        if let colorString = KeycapSettings.getBackgroundColor() as? String {
            let colorDictionary = KeycapColors.getDictionary()
            
            boardBackground.backgroundColor = colorDictionary[colorString]
        } else {
            boardBackground.backgroundColor = UIColor.lightGray
        }
    }


    
}
