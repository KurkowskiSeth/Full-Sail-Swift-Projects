//
//  Profile.swift
//  KurkowskiSeth_CE02
//
//  Created by Seth Kurkowski on 3/13/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
    
    let nameString = "nameString"
    let descriptionString = "descriptionString"
    let imageString = "imageString"
    
    var name: String
    var profileDescription: String
    var image: String
    
    init(_name: String, _description: String, _image: String) {
        self.name = _name
        self.profileDescription = _description
        self.image = _image
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(_name: "Nil", _description: "Nil", _image: "Nil")
        
        name = aDecoder.decodeObject(forKey: nameString) as! String
        profileDescription = aDecoder.decodeObject(forKey: descriptionString) as! String
        image = aDecoder.decodeObject(forKey: imageString) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameString)
        aCoder.encode(profileDescription, forKey: descriptionString)
        aCoder.encode(image, forKey: imageString)
    }
}
