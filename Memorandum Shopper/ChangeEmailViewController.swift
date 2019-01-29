//
//  ChangeEmailViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 1/24/19.
//  Copyright © 2019 Michael Sawlani. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ChangeEmailVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Email: UITextField!
    //Sends you back to settings
    @IBAction func Back(_ sender: Any) {
        self.performSegue(withIdentifier: "Settings", sender: self)
    }
    //Changes the email to what you entered and logs you out
    @IBAction func ChangeEmail(_ sender: Any) {
        guard let email = Email.text else{return}
        Auth.auth().currentUser?.updateEmail(to: email){ error in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Failed to Change Email", message: "Must enter email", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }else{
                let message = "You can now re-login as: " + email
                let alert = UIAlertController(title: "Successful Change to Email", message: message, preferredStyle: .alert)
                
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
        Email.resignFirstResponder()
        return (true)
    }
}
