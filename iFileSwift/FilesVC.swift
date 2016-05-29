//
//  FilesVC.swift
//  iFileSwift
//
//  Created by Henrique Dourado on 27/05/16.
//  Copyright © 2016 Henrique Dourado. All rights reserved.
//

import UIKit

class FilesVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pathTxtField: UITextField!
    @IBOutlet weak var testImgView: UIImageView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var deviceLbl: UILabel!
    @IBOutlet weak var exampleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    var type = 0
    var deviceLblTxt = ""
    
    /*
     type = 1 -> see directory
     type = 2 -> see files in directory
     type = 3 -> see image in directory
     */

    override func viewDidLoad() {
        super.viewDidLoad()
            searchBtn.layer.cornerRadius = 10
            deviceLbl.text = deviceLblTxt
        
            backBtn.layer.cornerRadius = backBtn.frame.width / 2
        
            if type == 1 {
                exampleLbl.text = "Example: /Applications"
            } else if type == 2 {
                exampleLbl.text = "Example: /System/Library/CoreServices/SystemVersion.plist"
            } else if type == 3 {
                exampleLbl.text = "Example: /Applications/AppStore.app/AppIcon60x60@2x.png"
            }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func searchBtnPressed(sender: AnyObject) {
        
        var message = ""
        var title = ""
        
        if let path = pathTxtField.text where path != "" {
            
            title = "Contents of \(path):"
            
            if type == 1 {
                message = "\(checkDirectoryForPath(path))"
            } else if type == 2 {
                message = "\(checkFilesForPath(path))"
            } else if type == 3 {
                if let img = checkImageForPath(path) {
                    testImgView.image = img
                    message = "A image was found at this path."
                } else {
                    title = "Error"
                    message = "No image found at this path"
                }
            } else {
                message = "Error"
            }
        } else {
            title = "Error"
            message = "Complete the field"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkDirectoryForPath(path: String) -> [String] {
        
        var contents = [String]()
        
        do {
            contents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(path)
            return contents
        } catch let err as NSError {
            print(err.debugDescription)
            return ["Error"]
        }
    }

    func checkFilesForPath(path: String) -> NSString {
        
        var contents: NSString = ""
        
        do {
            contents = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            return contents
        } catch let err as NSError {
            print(err.debugDescription)
            return "Error"
        }
    }
    
    func checkImageForPath(path: String) -> UIImage? {
        if let img = UIImage(contentsOfFile: path) {
            return img
        } else {
            return nil
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
