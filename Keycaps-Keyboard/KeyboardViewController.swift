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

    @IBOutlet var backspaceCollection:    [UIButton]!
    @IBOutlet var buttonCollection:       [UIButton]!
    @IBOutlet var modifierCollection:     [UIButton]!
    @IBOutlet var nextKeyboardCollection: [UIButton]!
    @IBOutlet var returnCollection:       [UIButton]!
    @IBOutlet var settingsCollection:     [UIButton]!
    @IBOutlet var shiftCollection:        [UIButton]!
    @IBOutlet var spacebarCollection:     [UIButton]!
    
    @IBOutlet var boardBackground:  UIView!
    @IBOutlet weak var numAlphaKey: UIButton!
    
    let colorDictionary = KeycapColors.getDictionary()
    var capsLockOn      = false
    var shiftOn         = true
    var defaultKeysOn   = true
    
    var heightConstraint: (Any)? = nil
    var alphaPageConstraint: (Any)? = nil
    var betaPageConstraint: (Any)? = nil
    var numbersPageConstraint: (Any)? = nil
    var specialCharacterPageConstraint: (Any)? = nil

    
    @IBOutlet var pageCollection: [UIStackView]!
    @IBOutlet weak var specialCharacterPage: UIStackView!
    @IBOutlet weak var numbersPage: UIStackView!
    @IBOutlet weak var betaPage: UIStackView!
    @IBOutlet weak var alphaPage: UIStackView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform custom UI setup here

        for shiftButton in shiftCollection { shiftButton.setTitle("\u{2b06}", for: .normal) }
        for settingButton in settingsCollection { settingButton.setTitle("\u{2699}", for: .normal) }
        for returnButton in returnCollection { returnButton.setTitle("\u{21B5}", for: .normal) }
        for backspaceButton in backspaceCollection { backspaceButton.setTitle("\u{232B}", for: .normal) }
        
        for nextButton in nextKeyboardCollection {
            nextButton.setTitle("\u{1F310}", for: .normal)
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        }

        styleAllButtons()
        updateHeightIfPlusSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkForPunctuation()
        checkForNoPrecedingText()
    }
    
    func dismissViewControllerAndReloadKeyboard() {
        styleAllButtons()
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil) { _ in
            self.updateViewConstraints()
            
            self.checkHeightConstraint()
            
            var height: CGFloat
            
            if UIScreen.main.bounds.size.height < UIScreen.main.bounds.size.width {
                //Keyboard is in Landscape
                
                height = 170
                self.fixConstraint(height)
                
                for page in self.pageCollection { page.layoutIfNeeded() }
                
            } else {
                //Keyboard is in Portrait
                
                ////
                // No constraints just default
                ////
                
                self.updateHeightIfPlusSize()
            }
        }
    }
    
    func updateHeightIfPlusSize() {
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 736.0 {
            self.fixConstraint(236)
        }
    }
    
    func fixConstraint(_ height: CGFloat) {
        self.heightConstraint = self.getHeightConstraint(height, self.view)
        self.view.addConstraint(self.heightConstraint as! NSLayoutConstraint)
        self.view.layoutIfNeeded()
    }
    
    func checkHeightConstraint() {
        if let constraint: NSLayoutConstraint = self.heightConstraint as? NSLayoutConstraint {
            self.view.removeConstraint(constraint)
            self.view.layoutIfNeeded()
        }
    }
    
    func getHeightConstraint(_ height: CGFloat, _ view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.init(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 0.0,
            constant: height
        )
    }
    
    ////
    // Typing
    ////
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        
        if shiftOn {
            (textDocumentProxy as UIKeyInput).insertText("\(string!.uppercased())")

            shiftOn = false
            if alphaPage.isHidden == false { toggleAlphaBetaBoards() }
            for shiftButton in shiftCollection { updateShift(button: shiftButton) }
        } else {
            (textDocumentProxy as UIKeyInput).insertText("\(string!.lowercased())")
        }
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
        checkForNoPrecedingText()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        checkForQuickPeriod()
        (textDocumentProxy as UIKeyInput).insertText(" ")
        checkForPunctuation()
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func showAlphaKeyboard(_ sender: UIButton) {
        toggleAlphaBetaBoards()
    }
    
    @IBAction func showNumbersKeyboard(_ sender: UIButton) {
        numbersPage.isHidden = false
        alphaPage.isHidden   = true
        betaPage.isHidden    = true
        specialCharacterPage.isHidden = true
    }
    
    @IBAction func showSpecialCharacterKeyboard(_ sender: UIButton) {
        numbersPage.isHidden = true
        alphaPage.isHidden   = true
        betaPage.isHidden    = true
        specialCharacterPage.isHidden = false
    }
    
    func toggleAlphaBetaBoards() {
        if shiftOn {
            numbersPage.isHidden = true
            alphaPage.isHidden   = false
            betaPage.isHidden    = true
            specialCharacterPage.isHidden = true
        } else {
            numbersPage.isHidden = true
            alphaPage.isHidden   = true
            betaPage.isHidden    = false
            specialCharacterPage.isHidden = true
        }
    }
    
    @IBAction func shiftPressed(button: UIButton) {
        shiftOn = !shiftOn
        
        toggleAlphaBetaBoards()
        
        for shiftButton in shiftCollection { updateShift(button: shiftButton) }
    }
    
    
    func updateShift(button: UIButton) -> Void {
        if shiftOn {
            for shiftButton in shiftCollection { shiftButton.setTitle("\u{2b06}", for: .normal) }
        } else {
            for shiftButton in shiftCollection { shiftButton.setTitle("\u{21e7}", for: .normal) }
        }
    }
    
    func checkForNoPrecedingText() {
        guard (textDocumentProxy.documentContextBeforeInput) != nil  else {
            shiftOn = true
            toggleAlphaBetaBoards()
            for shiftButton in shiftCollection { updateShift(button: shiftButton) }
            return
        }
        
    }
    
    func checkForPunctuation() {
        if let precedingContext: String = self.textDocumentProxy.documentContextBeforeInput {
            
            switch String(precedingContext.characters.suffix(2)) {
            case ". ", "? ", "! ":
                shiftOn = true
                toggleAlphaBetaBoards()
                for shiftButton in shiftCollection { updateShift(button: shiftButton) }
            default:
                shiftOn = false
                toggleAlphaBetaBoards()
                for shiftButton in shiftCollection { updateShift(button: shiftButton) }
            }
        }
    }
    
    func checkForQuickPeriod() {
        if let precedingContext: String = self.textDocumentProxy.documentContextBeforeInput {
            if precedingContext.characters.last! == " " {
                (textDocumentProxy as UIKeyInput).deleteBackward()
                (textDocumentProxy as UIKeyInput).insertText(".")
                
                shiftOn = true
                toggleAlphaBetaBoards()
                for shiftButton in shiftCollection { updateShift(button: shiftButton) }
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

        var allButtons: [UIButton] = buttonCollection + modifierCollection
        allButtons = allButtons + spacebarCollection
        
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
        
        checkForPunctuation()
        checkForNoPrecedingText()
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
        for button in spacebarCollection {
            styleLegendColor(for: button)
            styleSpacebarKeycapColor(for: button)
            styleSpacebarText(for: button)
        }
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
    
    func styleSpacebarKeycapColor(for spacebar: UIButton) {
        if let colorString = KeycapSettings.getSpaceBarColor() as? String {
            spacebar.backgroundColor = colorDictionary[colorString]
        } else {
            spacebar.backgroundColor = UIColor.darkGray
        }
    }
    
    func styleSpacebarText(for spacebar: UIButton) {
        if let spacebarText = KeycapSettings.getShowSpaceBarText() as? Int {
            spacebar.setTitle("space", for: .normal)
            if spacebarText == 0 {
                spacebar.setTitleColor(.clear, for: .normal)
            } else {
                if let colorString = KeycapSettings.getLegendColor() as? String {
                    spacebar.setTitleColor(colorDictionary[colorString], for: .normal)
                }
            }
        }
    }


    
}
