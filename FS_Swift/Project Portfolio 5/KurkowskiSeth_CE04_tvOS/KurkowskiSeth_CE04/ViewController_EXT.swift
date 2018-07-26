//
//  ViewController_EXT.swift
//  KurkowskiSeth_CE04
//
//  Created by Seth Kurkowski on 3/18/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import Foundation
extension ViewController {
    func createData1() -> [Item] {
        var items: [Item] = []
        
        //1
        items.append(Item.init(_title: "Friday the 13th", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "May 9, 1980", _category: "Section 1", _image: #imageLiteral(resourceName: "noun_654079_cc")))
        //2
        items.append(Item.init(_title: "Paranormal Activity", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "September 25, 2009", _category: "Section 1", _image: #imageLiteral(resourceName: "noun_188957_cc")))
        //3
        items.append(Item.init(_title: "Die Hard", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "July 15, 1988", _category: "Section 1", _image: #imageLiteral(resourceName: "noun_516111_cc")))
        //4
        items.append(Item.init(_title: "Raiders of the Lost Ark", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "June 12, 1981", _category: "Section 1", _image: #imageLiteral(resourceName: "noun_156405_cc")))
        //5
        items.append(Item.init(_title: "Jurassic Park", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "June 11, 1993", _category: "Section 1", _image: #imageLiteral(resourceName: "noun_626602_cc")))
        
        return items
    }
    
    func createData2() -> [Item] {
        var items: [Item] = []
        
        items.append(Item.init(_title: "Titanic", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "December 19, 1997", _category: "Section 2", _image: #imageLiteral(resourceName: "noun_654079_cc")))
        items.append(Item.init(_title: "Forrest Gumph", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "July 6, 1994", _category: "Section 2", _image: #imageLiteral(resourceName: "noun_626602_cc")))
        items.append(Item.init(_title: "Grease", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "June 16, 1978", _category: "Section 2", _image: #imageLiteral(resourceName: "noun_156405_cc")))
        items.append(Item.init(_title: "The Sound of Music", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "April 1, 1965", _category: "Section 2", _image: #imageLiteral(resourceName: "noun_516111_cc")))
        items.append(Item.init(_title: "Singin' in the Rain", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "April 11, 1952", _category: "Section 2", _image: #imageLiteral(resourceName: "noun_796558_cc")))
        
        return items
    }
    
    func createData3() -> [Item] {
        var items: [Item] = []
        
        items.append(Item.init(_title: "Pirates of the Caribbean: The Curse of the Black Pearl", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "June 28, 2003", _category: "Section 3", _image: #imageLiteral(resourceName: "noun_654079_cc")))
        items.append(Item.init(_title: "Ghostbustersh", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "June 8, 1984", _category: "Section 3", _image: #imageLiteral(resourceName: "noun_389730_cc")))
        items.append(Item.init(_title: "Airplane!", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "July 2, 1980", _category: "Section 3", _image: #imageLiteral(resourceName: "noun_796558_cc")))
        items.append(Item.init(_title: "Goodfellas", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "September 19, 1990", _category: "Section 3", _image: #imageLiteral(resourceName: "noun_1053967_cc")))
        items.append(Item.init(_title: "The Godfather", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis.", _dateCreated: "March 24, 1972", _category: "Section 3", _image: #imageLiteral(resourceName: "noun_1529612_cc")))
        
        return items
    }
}
