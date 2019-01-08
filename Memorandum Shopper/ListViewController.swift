//
//  FirstViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/6/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase

var grocerylist = [String]()
var asileNum = [String]()

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var List: UITableView!
    var refItem:DatabaseReference!
    var databaseHandled: DatabaseHandle?
    @IBAction func Save(_ sender: Any) {
        SaveItems()
    }
    
    @IBAction func Load(_ sender: Any) {
        LoadItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (grocerylist.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = grocerylist[indexPath.row]
        //cell.textLabel?.text = asileNum[indexPath.section]
        
        return (cell)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if  editingStyle == UITableViewCell.EditingStyle.delete
        {
            grocerylist.remove(at: indexPath.row)
            List.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        List.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refItem = Database.database().reference().child("items")
        

    }
    func SaveItems(){
    let key = refItem.childByAutoId().key
        let item = ["id":key!,
                    "Item Name": grocerylist] as [String : Any]
        
        refItem.child(key!).setValue(item)
        
    }
    
    func LoadItems(){
        databaseHandled = refItem?.child("items").observe(.childAdded, with: {(snapshot) in
            let item = snapshot.value as? String
            if let actualItem = item{
                grocerylist.append(actualItem)
                
                self.List.reloadData()
            }
        })
    }

}

