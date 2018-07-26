//
//  CongressmanCell.swift
//  KurkowskiSethCE5
//
//  Created by Seth Kurkowski on 9/18/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class CongressmanCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var party: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
