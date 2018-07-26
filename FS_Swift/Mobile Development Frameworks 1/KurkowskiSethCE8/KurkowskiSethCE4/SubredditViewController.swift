//
//  SubredditViewController.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 9/27/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class SubredditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Properties
    @IBOutlet weak var tableView: UITableView!
    //Array to hold the subreddits
    var subreddits = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreddits.count
    }
    
    //MARK: Configure Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_2")
        cell?.textLabel?.text = subreddits[indexPath.row]
        return cell!
    }
}
