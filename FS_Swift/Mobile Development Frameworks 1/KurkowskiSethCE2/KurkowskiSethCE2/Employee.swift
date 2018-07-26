//
//  Employee.swift
//  KurkowskiSethCE2
//
//  Created by Seth Kurkowski on 8/30/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

class Employee {
    //Stored Properties
    let employeeName: String
    let username: String
    let macAddress: String
    let currentTitle: String
    var skills: [String]! //This could be empty
    var employers: [Employers]! //This could be empty
    
    //Computed properties
    var numOfSkills: Int {
        return skills.count
    }
    var numOfEmployers: Int {
        return employers.count
    }
    
    var skillString: String {
        var string = ""
        for s in skills {
            string += s + "\n"
        }
        return string
    }
    
    var employerString: String {
        var string = ""
        for e in employers {
            string += e.responsibilitiesString
        }
        return string
    }
    
    //Inits
    init(employeeName: String, username: String, macAddress: String, currentTitle: String, skills: [String] = [String](), employers: [Employers] = [Employers]()){
        self.employeeName = employeeName
        self.username = username
        self.macAddress = macAddress
        self.currentTitle = currentTitle
        self.skills = skills
        self.employers = employers
    }
}
