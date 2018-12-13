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
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var reenterpasswordField: UITextField!
    @IBAction func signupButton(_ sender: Any) {
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        guard let reenterpassword = reenterpasswordField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password){
            user, error in
            if error == nil && user != nil && password == reenterpassword{
                print("Signup Successful")
                self.performSegue(withIdentifier: "MainMenu", sender: self)
            }else{
                print("Error Signing up: \(error!.localizedDescription)")
                
            }
            
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self .performSegue(withIdentifier: "Login", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //self.view.endEditing(true)
    
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return (true)
}

}
