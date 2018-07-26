//
//  Items.swift
//  KurkowskiSeth_CE04
//
//  Created by Seth Kurkowski on 3/18/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import UIKit
class Item: NSObject {
    let title: String
    let itemDescription: String
    let dateCreated: String
    let category: String
    let image: UIImage
    
    init( _title: String, _description: String, _dateCreated: String, _category: String, _image: UIImage) {
        title = _title
        itemDescription = _description
        dateCreated = _dateCreated
        category = _category
        image = _image
    }
}
