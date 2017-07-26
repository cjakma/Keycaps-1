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
    let pickerData: [String] = ["Red", "Orange", "Yellow", "Green",
                                "Cyan", "Blue", "Indigo", "Violet",
                                "Purple", "Magenta", "Pink", "Brown",
                                "White", "Gray" ,"Black"]
    
    let colorDictionary = ["Red": UIColor.red, "Orange": UIColor.orange, "Yellow": UIColor.yellow,
                           "Green": UIColor.green, "Cyan": UIColor.cyan, "Blue": UIColor.blue,
                           "Indigo": UIColor(red: 75/255, green: 0/255, blue: 130/255, alpha: 1.0),
                           "Violet": UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1.0),
                           "Purple": UIColor.purple, "Magenta": UIColor.magenta,
                           "Pink": UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1.0),
                           "Brown": UIColor.brown, "White": UIColor.white, "Gray": UIColor.gray ,
                           "Black": UIColor.black]

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
    }
    
    func updateColorBlock(to color: UIColor) -> Void {
        colorBlock.backgroundColor = color
    }


    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: {})
    }
}

