//
//  CongressData.swift
//  KurkowskiSethCE5
//
//  Created by Seth Kurkowski on 9/18/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class CongressData {
    
    //Stored properties
    let bioguideID: String
    let firstName: String
    let lastName: String
    let party: String
    let stateName: String
    let title: String
    
    //Stored properties
    var fullName: String {
        return "\(title). \(firstName) \(lastName)"
    }
    var partyName: String {
        switch party {
        case "D":
            return "Democrat"
        case "R":
            return "Republican"
        case "I":
            return "Independent"
        default:
            return "This should not show"
        }
    }
    
    //inits
    init (bioguideID: String, firstName: String, lastName: String, party: String, stateName: String, title: String) {
        self.bioguideID = bioguideID
        self.firstName = firstName
        self.lastName = lastName
        self.party = party
        self.stateName = stateName
        self.title = title
    }
}
