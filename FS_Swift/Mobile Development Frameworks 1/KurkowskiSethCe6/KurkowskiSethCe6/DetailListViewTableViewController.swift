//
//  DetailListViewTableViewController.swift
//  KurkowskiSethCe6
//
//  Created by Seth Kurkowski on 9/23/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class DetailListView: UITableViewController {
    
    var list: ShoppingLists!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //set left bar button to plus
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (DetailListView.addButtonTapped))
        
        //register header nibs
        let needHeaderNib = UINib.init(nibName: "NeededCutomHeader", bundle: nil)
        tableView.register(needHeaderNib, forHeaderFooterViewReuseIdentifier: "needHeaderID")
        
        let boughtHeaderNib = UINib.init(nibName: "BoughtCustomHeader", bundle: nil)
        tableView.register(boughtHeaderNib, forHeaderFooterViewReuseIdentifier: "boughtHeaderID")
        
        //Set title to name of list
        navigationItem.title = list.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return list.needed.count
        case 1:
            return list.bought.count
        default:
            return -1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! SecondTableCell
        
        // Configure the cell...
        switch indexPath.section {
        case 0:
            cell.itemName.text = list.needed[indexPath.row]
        default:
            cell.itemName.text = list.bought[indexPath.row]
        }
        
        return cell
    }
    
    //Set height for header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "needHeaderID") as? NeededCustomHeaderView
            
            //configure cell
            header?.totalItems.text = "Total Items: " + list.needed.count.description
            
            return header
        default:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "boughtHeaderID") as? BoughtCustomHeaderView
            
            //Configure cell
            header?.totalItems.text = "Total Items: " + list.bought.count.description
            
            return header
        }
    }
    
    func addButtonTapped() {
        let alert = UIAlertController(title: "Enter a name for the new item.", message: nil, preferredStyle: .alert)
        //Add addButton to alert controller
        let addButton = UIAlertAction(title: "ADD", style: .default) { (button) in
            //Add text field to the alert controller
            let newListName = alert.textFields![0]
            //check to make sure text field is not nil
            if let text = newListName.text {
                //Add item to list of needed
                self.list.needed.append(text)
                
                //reload table view
                self.tableView.reloadData()
            }
        }
        
        //Add cancel button to view controller
        let cancelButton = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
        
        //add text field
        alert.addTextField(configurationHandler: nil)
        
        //add buttons
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        //Present alert
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        //Set the trash button to be visable
        if tableView.isEditing {
            //Show trash button
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector (AllList_TVC.trashAllSelected))
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    func trashAllSelected() {
        
        //alert the user to make sure the wish to delete these items
        let alert = UIAlertController(title: "Are you sure you want to delete?", message: "This cannot be undone.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "YES", style: .default, handler: { (_) in
            
            var neededItemsToBeDeleted = [IndexPath]()
            var boughtItemsToBeDeleted = [IndexPath]()
            
            if let selectedIPs = self.tableView.indexPathsForSelectedRows {
                
                for ip in selectedIPs {
                    if ip.section == 0 {
                        neededItemsToBeDeleted.append(ip)
                    } else {
                        boughtItemsToBeDeleted.append(ip)
                    }
                }
                
                //sort both arrays
                neededItemsToBeDeleted.sort(by: { (a, b) -> Bool in
                    a.row > b.row
                })
                boughtItemsToBeDeleted.sort(by: { (a, b) -> Bool in
                    a.row > b.row
                })
                
                //remove from arrays
                for i in neededItemsToBeDeleted {
                    self.list.needed.remove(at: i.row)
                }
                for i in boughtItemsToBeDeleted {
                    self.list.bought.remove(at: i.row)
                }
                
                //remove all from the table view
                self.tableView.deleteRows(at: neededItemsToBeDeleted, with: .left)
                self.tableView.deleteRows(at: boughtItemsToBeDeleted, with: .left)
            }
            
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !tableView.isEditing {
            
            if let cell = tableView.indexPathForSelectedRow {
                
                if indexPath.section == 0 {
                    
                    //move to bought list
                    list.bought.append(list.needed[cell.row])
                    
                    //remove from needed list
                    list.needed.remove(at: cell.row)
                    
                    //reload data
                    tableView.reloadData()
                } else {
                    //move to needed list
                    list.needed.append(list.bought[cell.row])
                    
                    //remove from bought list
                    list.bought.remove(at: cell.row)
                    
                    //reload data
                    tableView.reloadData()
                }
            }
            
            tableView.deselectRow(at: indexPath, animated: false)
            
        }
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //alert the user to make sure the wish to delete these items
            let alert = UIAlertController(title: "Are you sure you want to delete?", message: "This cannot be undone.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "YES", style: .default, handler: { (_) in
                
                //Delete from array
                switch indexPath.section {
                case 0:
                    self.list.needed.remove(at: indexPath.row)
                default:
                    self.list.needed.remove(at: indexPath.row)
                }
                
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            })
            let cancelButton = UIAlertAction(title: "CANCEL", style: .destructive, handler: { (_) in
                self.tableView.isEditing = false
                
                //leave editing mode
                self.tableView.isEditing = false
                self.navigationItem.leftBarButtonItem = nil
            })
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
