//
//  ForgotPasswordViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 1/24/19.
//  Copyright © 2019 Michael Sawlani. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ForgotPasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBAction func Back(_ sender: Any) {
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    @IBOutlet weak var Email: UITextField!
    @IBAction func ResetPasswordLink(_ sender: Any) {
        guard let email = Email.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Failed to Send Link", message: "Must enter email", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }else{
                let message = "Check Email: " + email
                let alert = UIAlertController(title: "Successful Sending Link", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in                self.performSegue(withIdentifier: "Login", sender: self)

                }))
                
                self.present(alert, animated: true)
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Email.resignFirstResponder()
        return (true)
    }
}
