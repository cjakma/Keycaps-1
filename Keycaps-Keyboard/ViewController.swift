//
//  ViewController.swift
//  Keycaps
//
//  Created by Richard Rissanen on 7/25/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData:      [String]          = KeycapColors.getArray()
    let colorDictionary: [String: UIColor] = KeycapColors.getDictionary()
    
    var data: Data?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var colorBlock: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.delegate = self
        picker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let colorString = pickerData[row]
        updateColorBlock(to: colorDictionary[colorString]!)
        save(selected: colorString)
    }
    
    func updateColorBlock(to color: UIColor) -> Void {
        colorBlock.backgroundColor = color
    }
    
    func getSegueID(from data: Data) -> String {
        return data.base64EncodedString().fromBase64()!
    }


    func save(selected colorString: String) {
        
        let segueID = getSegueID(from: data!)
        
        switch segueID {
        case "backgroundColor":
            KeycapSettings.setBackground(colorString: colorString)
        case "buttonColor":
            KeycapSettings.setKeycap(colorString: colorString)
        case "borderColor":
            KeycapSettings.setBorder(colorString: colorString)
        case "letterColor":
            KeycapSettings.setLegend(colorString: colorString)
        case "modiferColor":
            KeycapSettings.setModifier(colorString: colorString)
        case "spacebarColor":
            KeycapSettings.setSpacebar(colorString: colorString)
        default:
          print(segueID)
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: {})
    }

}

