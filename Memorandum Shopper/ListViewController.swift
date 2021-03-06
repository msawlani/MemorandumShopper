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


var refresher: UIRefreshControl!



@available(iOS 13.0, *)
class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Variables
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var List: UITableView!
    var refItem:DatabaseReference!
    var databaseHandled: DatabaseHandle?
    var grocerylist: [Item] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //grocerylist.removeAll()
        
        List.dataSource = self
        List.delegate = self
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            DispatchQueue.main.async {
                self.List.reloadData()
            }
        }
        Refresher()
        
        refItem = Database.database().reference()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "item")
        
        request.returnsObjectsAsFaults = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        List.reloadData()
        List.dataSource = self
        List.delegate = self
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
            self.tabBarController?.tabBar.isHidden = true
         
        case false:
            Edit.setTitle("Edit", for: .normal)
            self.tabBarController?.tabBar.isHidden = false
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
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        guard let VC: UIViewController = main.instantiateViewController(identifier: "AddPopUpID") as? AddPopUPViewController else {
         return
        }
        navigationController?.pushViewController(VC, animated: true)

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
        return grocerylist.count
    }
    
    //Puts the items in the list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = List.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ViewControllerTableViewCell
        let items = grocerylist[indexPath.row]
        cell!.name.text = items.name
        cell!.asile.text = items.asile
        
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
            let item = snapshot.value as? Item
            let actualItem = item
            if actualItem != nil{
                
                self.grocerylist.append(actualItem!)
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

