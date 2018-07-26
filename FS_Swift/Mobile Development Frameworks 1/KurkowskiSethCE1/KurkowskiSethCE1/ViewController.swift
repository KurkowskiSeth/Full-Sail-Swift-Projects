//
//  ViewController.swift
//  KurkowskiSethCE1
//
//  Created by Seth Kurkowski on 8/28/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //properties
    var bars = [Bar]()
    var currentBar = 0
    @IBOutlet weak var lblBarName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblNumBartenders: UILabel!
    @IBOutlet weak var lblBartenders: UILabel!
    @IBOutlet weak var lblWeeklySales: UILabel!
    @IBOutlet weak var lblIsOpen: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Get path to CE1Data.json
        if let path = Bundle.main.path(forResource: "CE1Data", ofType: ".json"){
            
            //create url using the path
            let url = URL(fileURLWithPath: path)
            
            do {
                
                //Create data object to make data into a bianary format
                let data = try Data.init(contentsOf: url)
                
                //Create a json object and serialize the data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                //Call the method to parse the data.
                Parse(jsonObject: jsonObj)
                
            } catch {
                print(error.localizedDescription)
            }
            
            //Set the labels to the first item in the bars array
            showBar(barIndex: currentBar)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Create method to convert Serialized data into data that we can use in the application aka parsing
    func Parse(jsonObject: [Any]?) {
        //Bind the optional jsonObject to a non-optional one
        if let jsonObj = jsonObject {
            //loop through each item that is on the first level of the array.
            for firstLevelItem in jsonObj {
                //Check each item to make sure it has a value or is there.
                guard let obj = firstLevelItem as? [String: Any],
                let barName = obj["barName"] as? String,
                let city = obj["city"] as? String,
                let state = obj["state"] as? String,
                let bartenders = obj["bartenders"] as? [String],
                let weeklySales = obj["weeklySales"] as? Int,
                let isOpen = obj["isOpen"] as? Bool
                    else {return}
                
                //Append bar into the bars array
                bars.append(Bar(barName: barName, city: city, state: state, bartenders: bartenders, weeklySales: weeklySales, isOpen: isOpen))
            }
        }
    }
    //Create action to show next bar
    @IBAction func NextBar(_ sender: UIButton) {
        //Check to see if this is the last bar in the array
        if (currentBar + 1) == (bars.count) {
            //This means that it is the last bar in the array
            //Set the currentBar value to 0 and show that bar
            currentBar = 0
            showBar(barIndex: currentBar)
        } else {
            //This means that it is not the last bar in the array
            //Add one to the currentBar value and show that bar
            currentBar += 1
            showBar(barIndex: currentBar)
        }
    }
    
    //Create action to show previous bar
    @IBAction func PrevBar(_ sender: UIButton) {
        //Check to see if it is the first bar
        if currentBar == 0 {
            //This means it is the first bar
            //Set the currentBar value to be the last bar then show that bar
            currentBar = bars.count - 1
            showBar(barIndex: currentBar)
        } else {
            //This means that it isn't the first bar
            //Subtract 1 from the currentBar value then show that bar
            currentBar -= 1
            showBar(barIndex: currentBar)
        }
    }
    
    
    //Show bar function
    func showBar(barIndex: Int) {
        //Set each label according the barIndex
        lblBarName.text = bars[barIndex].barName
        lblLocation.text = bars[barIndex].cityState
        lblNumBartenders.text = String(bars[barIndex].numBartenders)
        lblBartenders.text = bars[barIndex].bartendersString
        lblWeeklySales.text = String(bars[barIndex].weeklySales)
        lblIsOpen.text = String(bars[barIndex].isOpen)
    }
}

