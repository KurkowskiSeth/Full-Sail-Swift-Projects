//
//  Leaderboard_TVC.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/19/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit
import CoreData

class Leaderboard_TVC: UITableViewController {
    
    //Properites
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    internal var managedContext: NSManagedObjectContext!
    internal var entityDescriotion: NSEntityDescription!
    internal var managedObject: NSManagedObject!
    var savedTimes = [(time: Int?, name: String?, moves: Int?, date: Date?)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedContext = appDelegate.managedObjectContext
        entityDescriotion = NSEntityDescription.entity(forEntityName: "HighScores", in: managedContext)
        
        savedTimes = loadSavedData()
        
        savedTimes = savedTimes.sorted(by: {$0.time! < $1.time!})
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return savedTimes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell

        // Configure the cell...
        let time = savedTimes[indexPath.row].time
        let dateComponents = savedTimes[indexPath.row].date!.description.components(separatedBy: " ")
        cell.nameLbl.text = savedTimes[indexPath.row].name
        cell.timeLbl.text = String(format: "%d:%02d", time! / 60, time! % 60)
        cell.movesLbl.text = savedTimes[indexPath.row].moves?.description
        cell.dateLbl.text = dateComponents[0]

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
