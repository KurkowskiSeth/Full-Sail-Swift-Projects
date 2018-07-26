//
//  TableViewController.swift
//  KurkowskiSethCE5
//
//  Created by Seth Kurkowski on 9/18/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //Create empty array to hold all members of congress
    var unsortedCongress = [CongressData]()
    
    //Create empty array or arrays to hold sorted congressmen
    var sortedCongress = [[CongressData](), [CongressData](), [CongressData]()]

     override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Load data
        donwloadCongressJSON()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedCongress[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? CongressmanCell
            else { return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) }

        // Configure the cell...
        cell.fullName.text = sortedCongress[indexPath.section][indexPath.row].fullName
        cell.party.text = sortedCongress[indexPath.section][indexPath.row].partyName
        switch cell.party.text! {
        case "Republican":
            cell.backgroundColor = UIColor.red
        case "Democrat":
            cell.backgroundColor = UIColor.blue
        default:
            cell.backgroundColor = UIColor.yellow
        }

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Get index path for the selected row
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedCongressman = sortedCongress[indexPath.section][indexPath.row]
            
            if let destination = segue.destination as? DetailVC {
                destination.congressman = selectedCongressman
            }
        }
    }
    
    
    //Header Methods
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Republican"
        case 1:
            return "Democrats"
        case 2:
            return "Independent"
        default:
            return "This should not display"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //function to download and parse congress data
    func donwloadCongressJSON() {
        //create a configuaton for the url session
        let config = URLSessionConfiguration.default
        
        //create a url session
        let session = URLSession(configuration: config)
        
        //check to make sure the url is valid
        if let validURL = URL(string: "https://congress.api.sunlightfoundation.com/legislators?apikey=[API_KEY]&per_page=all") {
            
            //create task to start the download of the data
            let task = session.dataTask(with: validURL, completionHandler: { (taskData, taskResponse, taskError) in
                
                //Check to make sure there are no errors before continuing
                if let error = taskError {
                    
                    //print error to console
                    print(error.localizedDescription)
                    return
                }
                
                //Check to response code to make sure the connection is good.
                guard let response = taskResponse as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = taskData
                    else {print("Problem with status code guard"); return}
                
                do {
                    //De-serialize the data downloaded from the url
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                        //Get the array of all current sitting congressmen's data
                        if let results = json["results"] as? [Any] {
                            
                            //loop through the array of congressmen
                            for congressman in results {
                                
                                //Grab the data that is needed form the array
                                guard let data = congressman as? [String: Any],
                                    let bioguide_id = data["bioguide_id"] as? String,
                                    let firstName = data["first_name"] as? String,
                                    let lastName = data["last_name"] as? String,
                                    let party = data["party"] as? String,
                                    let stateName = data["state_name"] as? String,
                                    let title = data["title"] as? String
                                    else {print("Problem with parse guard"); continue}
                                
                                //add new congressman to the unsorted array
                                self.unsortedCongress.append(CongressData(bioguideID: bioguide_id, firstName: firstName, lastName: lastName, party: party, stateName: stateName, title: title))
                            }

                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    //sort congress by party
                    for i in self.unsortedCongress {
                        switch i.party {
                        case "R":
                            self.sortedCongress[0].append(i)
                        case "D":
                            self.sortedCongress[1].append(i)
                        case "I":
                            self.sortedCongress[2].append(i)
                        default:
                            print("Error in sorting loop")
                        }
                    }
                    self.tableView.reloadData()
                }
                
            })
            task.resume()
        }
    }


}
