//
//  LoginViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/13/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate,GIDSignInUIDelegate, GIDSignInDelegate{
    
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
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print("Failed to login", error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("Failed to login", error)
                return
            }
            self.performSegue(withIdentifier: "MainMenu", sender: self)

            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let GoogleSignin = GIDSignInButton()
        GoogleSignin.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
        view.addSubview(GoogleSignin)
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    
}


func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //self.view.endEditing(true)
    
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return (true)
}

