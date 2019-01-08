//
//  FirstViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/6/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase

var grocerylist = [""]
var asileNum = [""]

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var List: UITableView!
    var refItem:DatabaseReference!
    @IBAction func Save(_ sender: Any) {
        ItemList()
    }
    
    @IBAction func Load(_ sender: Any) {
        
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
        
        refItem.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                grocerylist.removeAll()
                
                for items in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObject = items.value as? [String: AnyObject]
                    let itemName = itemObject?["Item Name"]
                    let id = itemObject?["id"]
                    
                    
                    
                    grocerylist.append(itemName as! String)
                }
            }
        })
    }
    func ItemList(){
    let key = refItem.childByAutoId().key
        let item = ["id":key!,
                    "Item Name": grocerylist] as [String : Any]
        
        refItem.child(key!).setValue(item)
        
    }

}

