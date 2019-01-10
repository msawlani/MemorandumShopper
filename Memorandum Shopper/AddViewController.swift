//
//  SecondViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/6/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate {


        
    @IBOutlet weak var Item: UITextField!
    @IBOutlet weak var Asile: UITextField!
    
    @IBAction func Add(_ sender: Any) {
        if  (Item.text != ""){
            grocerylist.append(Item.text!)
            Item.text = ""
            view.endEditing(true)

    }
    
    
        func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
            Item.delegate = self
            Asile.delegate = self
            
            
    }


}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Item.resignFirstResponder()
        Asile.resignFirstResponder()
        return (true)
    }
}
