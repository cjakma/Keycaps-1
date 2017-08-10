//
//  SettingsViewController.swift
//  Keycaps
//
//  Created by Richard Rissanen on 7/27/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var presentingVC: KeyboardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        presentingVC!.dismissViewControllerAndReloadKeyboard()
    }
    

}
