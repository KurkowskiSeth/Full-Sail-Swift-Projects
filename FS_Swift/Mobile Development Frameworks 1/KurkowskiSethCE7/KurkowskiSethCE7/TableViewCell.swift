//
//  TableViewCell.swift
//  KurkowskiSethCE7
//
//  Created by Seth Kurkowski on 9/25/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    //properties
    @IBOutlet weak var cityState: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var pop: UILabel!
    @IBOutlet weak var zip: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
