//
//  SettingsViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 1/8/19.
//  Copyright © 2019 Michael Sawlani. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITextFieldDelegate {
        
        
    @IBAction func Logout(_ sender: Any) {
        self.performSegue(withIdentifier: "MainMenu", sender: self)
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            
        }
        
        
    }

