//
//  SecondViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/6/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import UserNotifications

class AddViewController: UIViewController,UITextFieldDelegate {


        //variable
    @IBOutlet weak var Item: UITextField!
    @IBOutlet weak var ItemAdded: UILabel!
    
    //adds items to list
    @IBAction func Add(_ sender: Any) {
        if  (Item.text != ""){
            grocerylist.append(Item.text!)
            view.endEditing(true)
            ItemAdded.text = "Item Added: " + Item.text!;
            Item.text = ""
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
            Item.delegate = self
            
            
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    
    }
    
//Hides keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Item.resignFirstResponder()
        return (true)
    }
}
