//
//  FirstTableCell.swift
//  KurkowskiSethCe6
//
//  Created by Seth Kurkowski on 9/23/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class FirstTableCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var itemsNeeded: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
