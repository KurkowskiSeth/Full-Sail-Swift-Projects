//
//  ResultsTableViewController.swift
//  KurkowskiSethCE7
//
//  Created by Seth Kurkowski on 9/25/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    //Properties
    var resultsArray = [Results]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Function to clear all items from result page
    @IBAction func clearAll() {
        resultsArray.removeAll()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_1", for: indexPath) as? TableViewCell
        
        // Configure the cell...
        cell?.cityState.text = resultsArray[indexPath.row].cityState
        cell?.lat.text = "Latitude: " + resultsArray[indexPath.row].loc[0].description
        cell?.long.text = "Longitude: " + resultsArray[indexPath.row].loc[1].description
        cell?.pop.text = "Population: " + resultsArray[indexPath.row].pop.description
        cell?.zip.text = "Zip Code: " + resultsArray[indexPath.row].zip
        
        return cell!
    }
    
    //Get results from search controller
    @IBAction func unwindToRoot(segue: UIStoryboardSegue) {
        let source = segue.source as! SearchTableViewController
        resultsArray = source.filteredResults
        tableView.reloadData()
    }

}
