//
//  Employers.swift
//  KurkowskiSethCE2
//
//  Created by Seth Kurkowski on 8/30/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

class Employers {
    //stored properties
    let company: String
    var responsibilities: [String]! //This could be empty
    
    //computed properties
    var numOfResponsibilities: Int {
        return responsibilities.count
    }
    
    var responsibilitiesString: String {
        var string = "Company: \(company)\nTotal Responsibilities: \(numOfResponsibilities)"
        for r in responsibilities {
            string += "\n\t" + r
        }
        string += "\n"
        return string
    }
    
    //Inits
    init(company: String, responsibilities: [String] = [String]()) {
        self.company = company
        self.responsibilities = responsibilities
    }
}
