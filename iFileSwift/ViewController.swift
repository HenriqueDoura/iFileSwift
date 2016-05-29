//
//  ViewController.swift
//  iFileSwift
//
//  Created by Henrique Dourado on 27/05/16.
//  Copyright © 2016 Henrique Dourado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var deviceLbl: UILabel!
    
    var type = 0
    
    /* 
     type = 1 -> see directory
     type = 2 -> see files in directory
     type = 3 -> see image in directory
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let device = UIDevice()
        
            deviceLbl.text = "Version: \(device.systemVersion)"
        
            for button in buttons {
                button.layer.cornerRadius = 10
            }
    }
    
    @IBAction func directoryPressed(sender: AnyObject) {
        type = 1
        performSegueWithIdentifier("FilesVC", sender: type)
    }
    
    @IBAction func filesInDirectoryPressed(sender: AnyObject) {
        type = 2
        performSegueWithIdentifier("FilesVC", sender: type)
    }
    
    @IBAction func imgInDirectoryPressed(sender: AnyObject) {
        type = 3
        performSegueWithIdentifier("FilesVC", sender: type)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FilesVC" {
            if let vc = segue.destinationViewController as? FilesVC {
                if let type = sender as? Int {
                    vc.type = type
                    vc.deviceLblTxt = deviceLbl.text!
                }
            }
        }
    }
}

