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
    
    @IBOutlet weak var ChangeEmailAddress: UIButton!
    @IBOutlet weak var ChangePass: UIButton!
    //Sends you to change password for firebase
    @IBAction func ChangePassword(_ sender: Any) {

            self.performSegue(withIdentifier: "Password", sender: self)
        
   
    }
        //Sends you to change email for firebase
    @IBAction func ChangeEmail(_ sender: Any) {
 
        self.performSegue(withIdentifier: "Email", sender: self)
        
    
    }
    
    //logs google user and firebase user out
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
        if GIDSignIn.sharedInstance()?.currentUser == nil{
            ChangeEmailAddress.isEnabled = true
            ChangePass.isEnabled = true
        }else{
            ChangeEmailAddress.isEnabled = false
            ChangePass.isEnabled = false
        }
        }

    
  

    
        
        
    }

