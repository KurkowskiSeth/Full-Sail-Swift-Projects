//
//  Results.swift
//  KurkowskiSethCE7
//
//  Created by Seth Kurkowski on 9/25/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

class Results {
    //Stored Properties
    let city: String
    let loc: [Double]
    let pop: Int
    let stateID: String
    let zip: String
    private var statesDictionary = ["AL": "Alabama", "AK": "Alaska", "AZ": "Arizona", "AR": "Arkansas", "CA": "California", "CO": "Colorado", "CT": "Connecticut", "DE": "Delaware", "FL": "Florida", "GA": "Georgia", "HI": "Hawaii", "ID": "Idaho", "IL": "Illinois", "IN": "Indiana", "IA": "Iowa", "KS": "Kansas", "KY": "Kentucky", "LA": "Louisiana", "ME": "Maine", "MD": "Maryland", "MA": "Massachusetts", "MI": "Michigan", "MN": "Minnesota", "MS": "Mississippi", "MO": "Missouri", "MT": "Montana", "NE": "Nebraska", "NV": "Nevada", "NH": "New Hampshire", "NJ": "New Jersey", "NM": "New Mexico", "NY": "New York", "NC": "North Carolina", "ND": "North Dakota", "OH": "Ohio", "OK": "Oklahoma", "OR": "Oregon", "PA": "Pennsylvania", "RI": "Rhode Island", "SC": "South Carolina", "SD": "South Dakota", "TN": "Tennessee", "TX": "Texas", "UT": "Utah", "VT": "Vermont", "VA": "Virginia", "WA": "Washington", "WV": "West Virginia", "WI": "Wisconsin", "WY": "Wyoming", "DC": "District of Colombia"]
    
    //Calculated Properties
    var stateName: String {
        return statesDictionary[stateID]!
    }
    
    var cityState: String {
        return "\(city), \(stateID), \(zip)"
    }
    
    //Inits
    init(city: String, loc: [Double], pop: Int, stateID: String, zip: String) {
        self.city = city
        self.loc = loc
        self.pop = pop
        self.stateID = stateID
        self.zip = zip
    }
}
