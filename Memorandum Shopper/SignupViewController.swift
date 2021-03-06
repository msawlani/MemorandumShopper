//
//  SignupViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/13/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate{
    
    //Variables
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var PasswordFieldText: UITextField!
    @IBOutlet weak var reenterpasswordFieldText: UITextField!
    @IBOutlet weak var HideShow: UIButton!
    @IBOutlet weak var HideShow2: UIButton!
    
//Creates account for you when the user enters correct information
    @IBAction func signupButton(_ sender: Any) {
        guard let email = emailField.text else {return}
        guard let password = PasswordFieldText.text else {return}

        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil && self.PasswordFieldText.text != nil && self.PasswordFieldText.text == self.reenterpasswordFieldText.text{
                self.performSegue(withIdentifier: "MainMenu", sender: self)
                
            } else {
                let alert = UIAlertController(title: "Failed to Signup", message: "Must enter email and make sure the passwords match", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
        }
    
            
        
        
    }
    
    //Shows you how long password has to be
    @IBAction func Hint(_ sender: Any) {
        let alert = UIAlertController(title: "Password Length", message: "Password must be 8 - 16 characters", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //Shows password
    @IBAction func ShowPassword1(_ sender: Any) {
        if (HideShow.titleLabel?.text == "Show") {
            PasswordFieldText.isSecureTextEntry = false
            HideShow.setTitle("Hide", for: .normal)
        }
        else{
            PasswordFieldText.isSecureTextEntry = true
            HideShow.setTitle("Show", for: .normal)
        }
    }
    
    //Shows password
    @IBAction func ShowPassword2(_ sender: Any) {
        if (HideShow2.titleLabel?.text == "Show") {
            reenterpasswordFieldText.isSecureTextEntry = false
            HideShow2.setTitle("Hide", for: .normal)
        }
        else{
            reenterpasswordFieldText.isSecureTextEntry = true
            HideShow2.setTitle("Show", for: .normal)
        }
    }
    
    //Sends you back to login
    @IBAction func AlreadySignedUp(_ sender: Any) {
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    //allows you to hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        PasswordFieldText.resignFirstResponder()
        reenterpasswordFieldText.resignFirstResponder()
        return (true)
    }

}
