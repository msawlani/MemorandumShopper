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
import CoreData


var grocerylist: [Item] = []
var refresher: UIRefreshControl!


class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Variables
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var List: UITableView!
    var refItem:DatabaseReference!
    var databaseHandled: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //grocerylist.removeAll()
        
        List.dataSource = self
        List.delegate = self
        List.reloadData()
        Refresher()
        
        refItem = Database.database().reference()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "item")
        
        request.returnsObjectsAsFaults = false
    }
    
    
    // calls save function
    @IBAction func Save(_ sender: Any) {
        SaveItems()
    }
    
    //Allows you to edit the list and changes the name from done to edit
    @IBAction func EditList(_ sender: Any) {
        List.isEditing = !List.isEditing
        switch List.isEditing{
        case true:
            Edit.setTitle("Done", for: .normal)
        case false:
            Edit.setTitle("Edit", for: .normal)
        }
    }
    
    //Allows you to share list through any soical media and messages
    @IBAction func ShareList(_ sender: Any) {
        
        
        let sharelist = UIActivityViewController(activityItems: grocerylist, applicationActivities: nil)
        sharelist.popoverPresentationController?.sourceView = self.view
        self.present(sharelist, animated: true, completion: nil)
        
            
    }
    
    //Calls load function
    @IBAction func Load(_ sender: Any) {
        LoadItems()
    }
    @IBAction func Add(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add Items", message: "Please fill in to add something to the list", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { [unowned self] action in
        
            guard let nameTextField = alertController.textFields?.first, let name = nameTextField.text else {return}
            guard let asileTextField = alertController.textFields?.first, let asile = asileTextField.text else {return}
            
            grocerylist.append(name)
            self.List.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Allows for rows to be moved
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //lets the rows be moved
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = grocerylist[sourceIndexPath.row]
        grocerylist.remove(at: sourceIndexPath.row)
        grocerylist.insert(item, at: destinationIndexPath.row)
    }
    
    //Gets the number of rows from gorcery list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (grocerylist.count)
    }
    
    //Puts the items in the list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = List.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ViewControllerTableViewCell
        let items = grocerylist[indexPath.row]
        cell!.item.text = items
        
        return (cell!)
    }
    
    //Allows you to delete items
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

    
    //Saves items to firebase
    func SaveItems(){

        
    let userID = Auth.auth().currentUser!.uid

        let item = grocerylist
        
        refItem.child(userID).setValue(item)

        let message = "Items have been saved to: " + (Auth.auth().currentUser?.email)!
        let alert = UIAlertController(title: "Items Saved", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //loads items from firebase
    @objc func LoadItems(){
        
    let userID = Auth.auth().currentUser!.uid
        databaseHandled = refItem?.child(userID).observe(.childAdded, with: {(snapshot) in
            let item = snapshot.value as? String
            let actualItem = item
            if actualItem != nil && !grocerylist.contains(item!){
                
                grocerylist.append(actualItem!)
                self.List.reloadData()

                
                

            }
        })
        
        refresher.endRefreshing()
    }
    
    func Refresher(){
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refresher.addTarget(self, action: #selector(LoadItems), for: .valueChanged)
        List.addSubview(refresher)
    }

}

