//
//  ViewController.swift
//  KurkowskiSeth_CE04
//
//  Created by Seth Kurkowski on 3/18/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var section1Items: [Item] = []
    var section2Items: [Item] = []
    var section3Items: [Item] = []
    
    var selectedSection: Int = -1
    var selectedRow: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        section1Items = createData1()
        section2Items = createData2()
        section3Items = createData3()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = section1Items[indexPath.row].title
            cell.detailTextLabel?.text = section1Items[indexPath.row].category
        } else if indexPath.section == 1 {
            cell.textLabel?.text = section2Items[indexPath.row].title
            cell.detailTextLabel?.text = section2Items[indexPath.row].category
        } else {
            cell.textLabel?.text = section3Items[indexPath.row].title
            cell.detailTextLabel?.text = section3Items[indexPath.row].category
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedSection = indexPath.section
        selectedRow = indexPath.row
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        
        if selectedSection == 0 {
            destination?.itemTitle = section1Items[selectedRow].title
            destination?.dateCreated = section1Items[selectedRow].dateCreated
            destination?.category = section1Items[selectedRow].category
            destination?.itemDescription = section1Items[selectedRow].itemDescription
            destination?.itemImage = section1Items[selectedRow].image
        } else if selectedSection == 1 {
            destination?.itemTitle = section2Items[selectedRow].title
            destination?.dateCreated = section2Items[selectedRow].dateCreated
            destination?.category = section2Items[selectedRow].category
            destination?.itemDescription = section2Items[selectedRow].itemDescription
            destination?.itemImage = section2Items[selectedRow].image
        } else {
            destination?.itemTitle = section3Items[selectedRow].title
            destination?.dateCreated = section3Items[selectedRow].dateCreated
            destination?.category = section3Items[selectedRow].category
            destination?.itemDescription = section3Items[selectedRow].itemDescription
            destination?.itemImage = section3Items[selectedRow].image
        }
    }
}

