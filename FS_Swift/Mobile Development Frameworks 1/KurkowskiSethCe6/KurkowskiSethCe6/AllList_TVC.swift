//
//  AllList_TVC.swift
//  KurkowskiSethCe6
//
//  Created by Seth Kurkowski on 9/23/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class AllList_TVC: UITableViewController {
    //Properties
    var listArray = [ShoppingLists]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Hide trash button
        navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        //Regester header
        let headerNib = UINib.init(nibName: "CustomHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header_ID1")
        
        //Turn on select mode for editing
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //Load in the data
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FirstTableCell
        
        // Configure the cell...
        cell.name.text = listArray[indexPath.row].name
        cell.itemsNeeded.text = "Items Needed: " + listArray[indexPath.row].needed.count.description
        
        return cell
    }
    
    //Set height for header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    //Set up the header for table view
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID1") as? CustomHeader
        //configure header
        header?.total.text = "Total: " + listArray.count.description
        return header
    }
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        //Set the trash button to be visable
        if tableView.isEditing {
            //Show trash button
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector (AllList_TVC.trashAllSelected))
        } else {
            navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
            navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    func trashAllSelected() {
        //alert the user to make sure they wish to delete
        //ask user for confirmation they want to delete the lists with ur alert
        let alert = UIAlertController(title: "Are you sure you want to delete?", message: "This cannot be undone.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "YES", style: .default, handler: { (_) in
            
            //get selected IPs
            if var selectedIPs = self.tableView.indexPathsForSelectedRows {
                
                //sort from the largest to the smallest index then delete in that order
                selectedIPs.sort(by: { (a, b) -> Bool in
                    a.row > b.row
                })
                
                for ip in selectedIPs {
                    self.listArray.remove(at: ip.row)
                }
                
                //Delete all selected rows at once
                self.tableView.deleteRows(at: selectedIPs, with: .left)
            }
            //Reload
            self.tableView.reloadData()
            
            //leave editing mode
            self.tableView.isEditing = false
            self.navigationItem.leftBarButtonItem = nil
            
        })
        let cancelButton = UIAlertAction(title: "CANCEL", style: .destructive, handler: { (_) in
            self.tableView.isEditing = false
        })
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Enter a name for the new list.", message: nil, preferredStyle: .alert)
        //Add addButton to alert controller
        let addButton = UIAlertAction(title: "ADD", style: .default) { (button) in
            //Add text field to the alert controller
            let newListName = alert.textFields![0]
            //check to make sure text field is not nil
            if let text = newListName.text {
                //Add list to array
                self.listArray.append(ShoppingLists(name: text))
                
                //reload table view
                self.tableView.reloadData()
            }
        }
        
        //Add cancel button to view controller
        let cancelButton = UIAlertAction(title: "CANCEL", style: .destructive, handler: { (_) in
            self.tableView.isEditing = false
        })
        //add text field
        alert.addTextField(configurationHandler: nil)
        
        //add buttons
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        //Present alert
        present(alert, animated: true, completion: nil)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //ask user for confirmation they want to delete the lists with ur alert
            let alert = UIAlertController(title: "Are you sure you want to delete?", message: "This cannot be undone.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "YES", style: .default, handler: { (_) in
                //Delete from array
                self.listArray.remove(at: indexPath.row)
                
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            
            //leave editing mode
            self.tableView.isEditing = false
            self.navigationItem.leftBarButtonItem = nil
            
            let cancelButton = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            present(alert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
        if let indexPath = tableView.indexPathForSelectedRow {
            let listToSend = listArray[indexPath.row]
            
            if let destination = segue.destination as? DetailListView {
                destination.list = listToSend
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tableView.isEditing {
            return false
        } else {
            return true
        }
    }
    
    
    //Load Data
    func loadData() {
        //Load in and parse data from file
        if let path = Bundle.main.path(forResource: "CE6Data", ofType: ".json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data.init(contentsOf: url)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                guard let json = jsonObj
                    else {print("Failed to unwrap jsonObj"); return}
                for flo in json {
                    guard let obj = flo as? [String: Any],
                        let name = obj["name"] as? String,
                        let items = obj["items"] as? [String]
                        else {print("Error in flo loop guard"); return}
                    
                    //Add item to the array of lists
                    listArray.append(ShoppingLists(name: name, needed: items))
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
