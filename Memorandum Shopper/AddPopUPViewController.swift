//
//  AddPopUPViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 10/26/19.
//  Copyright © 2019 Michael Sawlani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AddPopUPViewController: UIViewController {

    @IBOutlet weak var nameFieldText: UITextField!
    @IBOutlet weak var asileFieldText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add Item"
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func AddBTN(_ sender: Any) {
        let item = CreateItem()
        
        guard let home = navigationController?.viewControllers.first as? ListViewController else {
            return
        }
        
        home.grocerylist.append(item)
       
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func CancelBTN(_ sender: Any) {
    

        self.navigationController?.popViewController(animated: true)
    }
    

    func CreateItem() -> Item {
        let item = Item(name: self.nameFieldText.text!, asile: self.asileFieldText.text!)
        
        return item
    }
    

    


}
