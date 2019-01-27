//
//  FirstViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/6/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

var grocerylist = [String()]


class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var List: UITableView!
    var refItem:DatabaseReference!
    var databaseHandled: DatabaseHandle?
    @IBAction func Save(_ sender: Any) {
        SaveItems()
    }
    @IBAction func EditList(_ sender: Any) {
        List.isEditing = !List.isEditing
        switch List.isEditing{
        case true:
            Edit.setTitle("Done", for: .normal)
        case false:
            Edit.setTitle("Edit", for: .normal)
        }
    }
    
    @IBAction func ShareList(_ sender: Any) {
        

        let sharelist = UIActivityViewController(activityItems: grocerylist, applicationActivities: nil)
        sharelist.popoverPresentationController?.sourceView = self.view
        self.present(sharelist, animated: true, completion: nil)
        
            
    }
    @IBAction func Load(_ sender: Any) {
        LoadItems()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = grocerylist[sourceIndexPath.row]
        grocerylist.remove(at: sourceIndexPath.row)
        grocerylist.insert(item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (grocerylist.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = grocerylist[indexPath.row]
        
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
        
        refItem = Database.database().reference()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })

    }
    func SaveItems(){

        
    let userID = Auth.auth().currentUser!.uid

        let item = grocerylist
        
        refItem.child(userID).setValue(item)

    }
    
    func LoadItems(){
        
    let userID = Auth.auth().currentUser!.uid
        databaseHandled = refItem?.child(userID).observe(.childAdded, with: {(snapshot) in
            let item = snapshot.value as? String
            let actualItem = item
            if actualItem != nil && !grocerylist.contains(item!){
                
                grocerylist.append(actualItem!)
                self.List.reloadData()
                
                

            }
        })
    }

}

