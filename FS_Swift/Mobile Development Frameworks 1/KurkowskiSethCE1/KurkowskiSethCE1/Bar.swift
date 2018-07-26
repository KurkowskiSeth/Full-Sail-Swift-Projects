//
//  Bar.swift
//  KurkowskiSethCE1
//
//  Created by Seth Kurkowski on 8/28/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

class Bar {
    //Properties
    var barName: String
    var city: String
    var state: String
    var bartenders: [String]
    var weeklySales: Int
    var isOpen: Bool
    var cityState: String {
        get {
            return "\(city), \(state)"
        }
    }
    var numBartenders: Int {
        get {
            return bartenders.count
        }
    }
    var bartendersString: String {
        get {
            return "\(bartenders[0])\n\(bartenders[1])\n\(bartenders[2])"
        }
    }
    
    //Initializers
    init (barName: String, city: String, state: String, bartenders: [String], weeklySales: Int, isOpen: Bool) {
        self.barName = barName
        self.city = city
        self.state = state
        self.bartenders = bartenders
        self.weeklySales = weeklySales
        self.isOpen = isOpen
    }
}
