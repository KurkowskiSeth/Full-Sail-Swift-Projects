//
//  SearchTableViewController.swift
//  KurkowskiSethCE7
//
//  Created by Seth Kurkowski on 9/25/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    //Properties
    var results = [Results]()
    var filteredResults = [Results]()
    //Create search controller object
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        //download all data from json
        download()
        
        //Set up the search controller
        //Don't let screen dim
        searchController.dimsBackgroundDuringPresentation = false
        //Let the table view decide the size
        self.definesPresentationContext = true
        //Set the search bar to recieve updates
        searchController.searchResultsUpdater = self
        
        //Set up search bar of the search controller
        //Give search bar scops to search
        searchController.searchBar.scopeButtonTitles = ["City", "State", "Zip Code"]
        //Register delegate
        searchController.searchBar.delegate = self
        //Add search bar to the table view
        tableView.tableHeaderView = searchController.searchBar
        
        //Make sure the search bar is the right size
        searchController.searchBar.sizeToFit()
        
        navigationController?.title = "Search"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //Call filter function
        filterResults()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //Call filter function
        filterResults()
    }
    
    //Filter Results
    func filterResults() {
        //Get text from the search bar
        let searchBarText = searchController.searchBar.text!
        
        //Find out wich scorp is selected
        let selectedScorpIndex = searchController.searchBar.selectedScopeButtonIndex
        
        //filter based on selected scorp
        switch selectedScorpIndex {
        case 0:
            filteredResults = results.filter({ (result) -> Bool in
                //result.city.lowercased().contains(searchBarText.lowercased())
                result.city.lowercased().contains(searchBarText.lowercased())
            })
        case 1:
            filteredResults = results.filter({ (result) -> Bool in
                result.stateName.lowercased().contains(searchBarText.lowercased())
            })
        case 2:
            filteredResults = results.filter({ (result) -> Bool in
                result.zip.contains(searchBarText)
            })
        default:
            print("Error in search bar results switch.")
        }
        
        //reload table view
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //Check to see if search controller is active
        if searchController.isActive {
            return filteredResults.count
        }
        else {
            return results.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_2", for: indexPath)

        // Configure the cell...
        //check to see if search controller is active
        if searchController.isActive {
            cell.textLabel?.text = filteredResults[indexPath.row].cityState
        }
        else {
            cell.textLabel?.text = results[indexPath.row].cityState
        }

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //tell navigation controller to go back to root controller
        //Source: https://stackoverflow.com/questions/28760541/programmatically-go-back-to-previous-viewcontroller-in-swift
        self.navigationController?.popToRootViewController(animated: true)
        //perform unwind segue
        performSegue(withIdentifier: "unwindToRoot", sender: self)
    }
}
