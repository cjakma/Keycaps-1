//
//  MoreSettingsTableViewController.swift
//  Keycaps
//
//  Created by Richard Rissanen on 7/27/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import UIKit

class MoreSettingsTableViewController: UITableViewController {
    
    let truthy: NSNumber  = 1
    let falsy:  NSNumber  = 0
    
    let normalTextSize: NSNumber = 15
    let largeTextSize:  NSNumber = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func toggleLargeText(_ sender: UISwitch) {
        if sender.isOn {
            KeycapSettings.toggleShowLargeText(to: largeTextSize)
        } else {
            KeycapSettings.toggleShowLargeText(to: normalTextSize)
        }
    }
    
    @IBAction func toggleRoundedCorners(_ sender: UISwitch) {
        if sender.isOn {
            KeycapSettings.toggleShowRoundedCorners(to: truthy)
        } else {
            KeycapSettings.toggleShowRoundedCorners(to: falsy)
        }
    }
    
    @IBAction func toggleSpacebarText(_ sender: UISwitch) {
        if sender.isOn {
            KeycapSettings.toggleShowSpaceBarText(to: truthy)
        } else {
            KeycapSettings.toggleShowSpaceBarText(to: falsy)
        }
    }
    
    @IBAction func toggleBorders(_ sender: UISwitch) {
        if sender.isOn {
            KeycapSettings.toggleShowBorder(to: truthy)
        } else {
            KeycapSettings.toggleShowBorder(to: falsy)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextScene = segue.destination as? ViewController {
            let segueID = segue.identifier
            let baseEncodedSegueID = segueID?.toBase64()

            nextScene.data = Data.init(base64Encoded: baseEncodedSegueID!)
        }
    }
    


}
