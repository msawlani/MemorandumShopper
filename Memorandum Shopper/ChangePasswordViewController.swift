//
//  ChangePasswordViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 1/24/19.
//  Copyright © 2019 Michael Sawlani. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ChangePasswordVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var reenterPassword: UITextField!
    
    @IBOutlet weak var HideShow: UIButton!
    
    @IBOutlet weak var HideShow2: UIButton!
    
    //sends you back to settings
    @IBAction func Back(_ sender: Any) {
        self.performSegue(withIdentifier: "Settings", sender: self)
    }
    
    //shows you how long password has to be
    @IBAction func Hint(_ sender: Any) {
        let alert = UIAlertController(title: "Password Length", message: "Password must be 8 - 16 characters", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    //shows you the password
    @IBAction func ShowPassword(_ sender: Any) {
        if (HideShow.titleLabel?.text == "Show") {
            Password.isSecureTextEntry = false
            HideShow.setTitle("Hide", for: .normal)
        }
        else{
            Password.isSecureTextEntry = true
            HideShow.setTitle("Show", for: .normal)
        }
    }
    
    //shows you the password
    @IBAction func ShowPassword2(_ sender: Any) {
        if (HideShow2.titleLabel?.text == "Show") {
            reenterPassword.isSecureTextEntry = false
            HideShow2.setTitle("Hide", for: .normal)
        }
        else{
            reenterPassword.isSecureTextEntry = true
            HideShow2.setTitle("Show", for: .normal)
        }
    }
    
    //changes the password your password to what you entered and logs you out
    @IBAction func ChangePassword(_ sender: Any) {
        guard let password = Password.text else{return}

        Auth.auth().currentUser?.updatePassword(to: password){ error in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Failed to Change Password", message: "Passwords must match!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }else{
                let message = "You can now re-login with your new password"
                let alert = UIAlertController(title: "Successful Change to Password", message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                    do{
                        try Auth.auth().signOut()
                        self.performSegue(withIdentifier: "Login", sender: self)
                    }catch let Logouterror{
                        print(Logouterror)
                    }
                    
                    
                }))
                
                self.present(alert, animated: true)
            }
        }
     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    //hides keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Password.resignFirstResponder()
        reenterPassword.resignFirstResponder()
        return (true)
    }
}
