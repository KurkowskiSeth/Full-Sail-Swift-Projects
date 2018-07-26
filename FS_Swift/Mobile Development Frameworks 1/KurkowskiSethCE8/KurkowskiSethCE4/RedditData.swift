//
//  RedditData.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 9/6/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation
import UIKit

class RedditData {
    //Stored Properties
    let title: String
    let author: String
    var image: UIImage!
    
    //Computed Properties
    var authorString: String {
        return "Author: \(author)"
    }
    
    //inits
    init (title: String, author: String, imageString: String) {
        self.title = title
        self.author = author
        
        //Create another session and task to load the image
        if let url = URL(string: imageString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                //Return if there is an error
                if error != nil {
                    return
                }
                
                //check status code and save the data
                guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data
                    else {return}
                
                //save the image
                self.image = UIImage(data: data)
            })
            task.resume()
        }
    }
}
