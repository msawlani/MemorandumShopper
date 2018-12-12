//
//  FirstViewController.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/6/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit

var grocerylist = [""]
var asileNum = ["1"]

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var List: UITableView!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (grocerylist.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = grocerylist[indexPath.row]
        cell.textLabel?.text = asileNum[indexPath.row]
        
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
    }


}

