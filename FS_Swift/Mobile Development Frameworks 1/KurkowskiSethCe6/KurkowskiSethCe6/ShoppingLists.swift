//
//  ShoppingLists.swift
//  KurkowskiSethCe6
//
//  Created by Seth Kurkowski on 9/23/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

class ShoppingLists {
    //Stored Properties
    let name: String
    var needed: [String]!
    var bought: [String]!
    
    //Inits
    init (name: String, needed: [String] = [String](), bought: [String] = [String]()) {
        self.name = name
        self.needed = needed
        self.bought = bought
    }
}
