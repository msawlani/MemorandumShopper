//
//  ViewControllerTableViewCell.swift
//  Memorandum Shopper
//
//  Created by Michael Sawlani on 12/12/18.
//  Copyright © 2018 Michael Sawlani. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var asile: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
