//
//  LoginViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/13/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var HideShow: UIButton!
    @IBOutlet weak var passwordField: UITextField!
     
    @IBAction func ShowPassword(_ sender: Any) {
        if (HideShow.titleLabel?.text == "Show") {
            passwordField.isSecureTextEntry = false
            HideShow.setTitle("Hide", for: .normal)
        }
        else{
            passwordField.isSecureTextEntry = true
            HideShow.setTitle("Show", for: .normal)
        }


    }
    @IBAction func ForgotPassword(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ForgotPassword", sender: self)
    }
    
    @IBAction func loginButton(_ sender: Any) {

        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil && self.passwordField != nil{
                self.performSegue(withIdentifier: "MainMenu", sender: self)

            } else {
                let alert = UIAlertController(title: "Failed to Login", message: "Must enter email and password", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
    
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
         self.performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
}


func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //self.view.endEditing(true)
    
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return (true)
}

