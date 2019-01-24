//
//  SettingsViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 1/8/19.
//  Copyright © 2019 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import GoogleSignIn

class SettingsViewController: UIViewController,UITextFieldDelegate {
    
        
    @IBAction func AllowNotifications(_ sender: Any) {

    }
    
    @IBAction func ChangePassword(_ sender: Any) {
        self.performSegue(withIdentifier: "Password", sender: self)
    }
    
    @IBAction func ChangeEmail(_ sender: Any) {
        self.performSegue(withIdentifier: "Email", sender: self)
    }
    @IBAction func Logout(_ sender: Any) {
        do{
            try
                Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
        }catch let logouterror{
            print(logouterror)
        }
        self.performSegue(withIdentifier: "Login", sender: self)

    }
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            
        }
        
        
    }

