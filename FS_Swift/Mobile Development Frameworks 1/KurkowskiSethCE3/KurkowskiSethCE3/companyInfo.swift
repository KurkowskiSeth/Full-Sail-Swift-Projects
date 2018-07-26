//
//  companyInfo.swift
//  KurkowskiSethCE3
//
//  Created by Seth Kurkowski on 9/2/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

class companyInfo {
    //Stored properties
    let catchPhrase: String
    let revene: Double! //Might be empty
    let colors: [Colors]
    
    //Computed Properties
    var colorString: String {
        var string = ""
        for c in colors {
            string += "Description: \(c.description)\nColor: \(c.color)\n\n"
        }
        return string
    }
    
    var reveneString: String! {
        if let rev = revene {
            return "$\(rev.description)"
        } else {
            return "No Info"
        }
    }
    
    //Inits
    init(catchPhrase: String, colors: [Colors], revene: Double! = nil) {
        self.catchPhrase = catchPhrase
        self.revene = revene
        self.colors = colors
    }
    
    convenience init(catchPhrase: String, colors: [Colors], reveneString: String) {
        //trim the doller sign from reveneString
        let reveveDouble = Double(reveneString.trimmingCharacters(in: .init(charactersIn: "$")))
        
        //Call designated init
        self.init(catchPhrase: catchPhrase, colors: colors, revene: reveveDouble)
    }
}
