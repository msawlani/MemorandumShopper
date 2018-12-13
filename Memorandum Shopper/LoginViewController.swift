//
//  LoginViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/13/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signupButton(_ sender: Any){
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

