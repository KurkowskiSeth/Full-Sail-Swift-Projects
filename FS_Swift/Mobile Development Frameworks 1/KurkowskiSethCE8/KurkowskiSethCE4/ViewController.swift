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
    var redditArray = [[RedditData]]()
    //Array for each subreddit
    var subreddits = ["mildlyinteresting"]
    var urlStarting = "https://www.reddit.com/r/"
    var urlEnding = ".json"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Register nib
        let headerNib = UINib(nibName: "RedditHeader", bundle: nil)
        reditTable.register(headerNib, forHeaderFooterViewReuseIdentifier: "header_1")
        
        //Download data from json
        download()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return subreddits.count
    }
    
    //MARK: -Configuring Section Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_1") as? RedditHeaderView
        header?.title.text = subreddits[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }
    
    //MARK: -Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditArray.count
    }
    
    //MARK: -Configuring cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure a new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID_1", for: indexPath)
        
        //Set UI
        cell.textLabel?.text = redditArray[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text = redditArray[indexPath.section][indexPath.row].authorString
        cell.imageView?.image = redditArray[indexPath.section][indexPath.row].image
        
        //return confiigured cell
        return cell
    }
    
    //MARK: -Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? SubredditViewController
        destination?.subreddits = subreddits
    }
}

