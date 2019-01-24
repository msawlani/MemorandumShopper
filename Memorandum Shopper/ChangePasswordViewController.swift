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
    
    @IBAction func ChangPassword(_ sender: Any) {
        guard let password = Password.text else{return}
        guard let reEnterPassword = reenterPassword.text else{return}
        Auth.auth().currentUser?.updatePassword(to: password){ error in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Failed to Change Password", message: "Must enter Password", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }else{
                if password == reEnterPassword{
                let message = "You can now re-login with your new password"
                    let alert = UIAlertController(title: "Successful Change to Password", message: message, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                        do{
                            try Auth.auth().signOut()
                        }catch let Logouterror{
                            print(Logouterror)
                        }
                        
                        self.performSegue(withIdentifier: "Login", sender: self)
                        
                    }))
                
                self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Failed to Change Password", message: "Both passwords must match", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
