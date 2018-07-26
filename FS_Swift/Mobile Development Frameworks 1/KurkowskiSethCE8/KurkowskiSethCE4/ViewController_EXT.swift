//
//  ViewController_EXT.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 9/27/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

extension ViewController {
    
    //MARK: -Download Data
    func download() {
        //download the data from url
        //create a configuation
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        for reddit in subreddits {
            if let validURL = URL(string: "\(urlStarting)\(reddit)\(urlEnding)") {
                //Create a task to load in the data
                let task = session.dataTask(with: validURL, completionHandler: { (data, response, error) in
                    //test error to see if need to back out of task
                    if error != nil {return}
                    //check the reponse code and load the data
                    guard let response = response as? HTTPURLResponse,
                        response.statusCode == 200,
                        let data = data
                        else {return}
                    do {
                        //de-serialize the data from the data
                        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as Any? {
                            
                            //Parse data
                            guard let json = jsonObject as? [String: Any],
                                let dataObject = json["data"] as Any?,
                                let data = dataObject as? [String: Any],
                                let children = data["children"] as? [Any]
                                else {print("No Data Found"); return}
                            
                            //loop through each object in the children array and continue parsing
                            for object in children {
                                guard let obj = object as? [String: Any],
                                    let data2Object = obj["data"] as Any?,
                                    let data2 = data2Object as? [String: Any],
                                    let title = data2["title"] as? String,
                                    let author = data2["author"] as? String
                                    else {print("No data found in first object array"); continue}
                                //check to see if post has a thumbnail if it does add to array if not do nothing with post.
                                guard let thumbnail = data2["thumbnail"] as? String,
                                    thumbnail != "self",
                                    thumbnail != "defult"
                                    else {print("No Thumbnail"); return}
                                //Create a new RedditData object and add to redditArray
                                var newReddit = [RedditData]()
                                newReddit.append(RedditData(title: title, author: author, imageString: thumbnail))
                                self.redditArray.append(newReddit)
                            }
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                })
                task.resume()
                DispatchQueue.main.async {
                    self.reditTable.reloadData()
                }
            }
        }
    }
}
