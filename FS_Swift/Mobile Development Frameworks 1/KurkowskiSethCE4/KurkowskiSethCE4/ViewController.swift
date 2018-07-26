//
//  ViewController.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 9/6/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //properties
    @IBOutlet weak var reditTable: UITableView!
    
    //Create emplty array to hold objects to display
    var redditArray = [RedditData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //download the data from url
        //create a configuation
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let validURL = URL(string: "https://www.reddit.com/r/mildlyinteresting/.json") {
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
                            if let thumbnail = data2["thumbnail"] as? String {
                                //Create a new RedditData object and add to redditArray
                                self.redditArray.append(RedditData(title: title, author: author, imageString: thumbnail))
                            }
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                //Bring back to main thread
                DispatchQueue.main.async {
                    //reload the table view
                    self.reditTable.reloadData()
                }
            })
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure a new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID_1", for: indexPath)
        
        //Set UI
        cell.textLabel?.text = redditArray[indexPath.row].title
        cell.detailTextLabel?.text = redditArray[indexPath.row].authorString
        cell.imageView?.image = redditArray[indexPath.row].image
        
        //return confiigured cell
        return cell
    }

}

