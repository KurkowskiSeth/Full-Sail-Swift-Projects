//
//  ViewController.swift
//  KurkowskiSethCE3
//
//  Created by Seth Kurkowski on 9/1/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblCatchPhrase: UILabel!
    @IBOutlet weak var lblReneve: UILabel!
    @IBOutlet weak var txtColors: UITextView!
    
    var currentIndex = 1
    var companies = [Company]()
    var infoArray = [companyInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create a URL default configuation
        let config = URLSessionConfiguration.default
        
        //Create a URL session
        let session = URLSession(configuration: config)
        
        //Check the url to make sure it is not broken
        if let validURL = URL(string: "https://api.myjson.com/bins/9kj3f") {
            //create a task for the session to download the data from the url into a data object
            let task = session.dataTask(with: validURL, completionHandler: { (data, response, error) in
              //Check to see if there is an error and if there is then return the task so it won't crash the program
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                //Check response from dataTask to make sure we have valid data
                guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let validData = data
                    else { print("JSON creation failed"); return }
                do {
                    //Serialize the data from the url into an array of any objects
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                    
                    //Parse the data
                    self.ParseFirst(jsonObject: jsonObj)
                    
                    //Call function to continue loading in data from the second url
                    self.loadInSecondData(session: session)
                }
                catch {
                    print(error.localizedDescription)
                }
            })
            //Resume the task
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Create function to load in data from the second url
    func loadInSecondData(session: URLSession) {
        //Repeat what was done for the first url for the second url
        //Check new url to make sure it is valid
        if let validURL = URL(string: "https://api.myjson.com/bins/1cxa6j") {
            //create another task to download data
            let task = session.dataTask(with: validURL, completionHandler: { (data, response, error) in
                //Check for errors
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                //Check reponse code to make sure it is valid data
                guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let validData = data
                    else {print("Second JSON creation failed"); return}
                do {
                    //Serialize te dat form the url into an array of any objects
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                    //parse data
                    self.ParseSecond(jsonObject: jsonObj)
                }
                catch {
                    print(error.localizedDescription)
                }
            })
            //Resume the task
            task.resume()
        }
    }
    
    //Create function to parse data from the first url
    func ParseFirst(jsonObject: [Any]?) {
        //Check to see if jsonObject can be unwrapped
        guard let json = jsonObject
            else {print("Failed to unwrap jsonObject"); return}
        
        //Loop throught the first level items in the data array
        for firstLevelItem in json {
            //Try to convert items
            guard let obj = firstLevelItem as? [String: Any],
            let name = obj["name"] as? String,
            let version = obj["version"] as? String,
            let company = obj["company"] as? String
                else {continue}
            //create a new company object and add it to the array of companies
            companies.append(Company(name: name, version: version, company: company))
        }
    }
    
    //Create function to parse data from the second url
    func ParseSecond(jsonObject: [Any]?) {
        //Check to make sure jsonObject can be unwrapped
        guard let json = jsonObject
            else { print("Failed to unwrap second jsonObject"); return }
        
        //Loop through the first level item in data array
        for firstLevelItem in json {
            //Create array to hold color objects 
            var colorsArray = [Colors]()
            //Try to convert items that should have values
            guard let obj = firstLevelItem as? [String: Any],
            let catchPhrase = obj["catch_phrase"] as? String,
            let colors = obj["colors"] as? [Any]
                else {continue}
            //loop throught the second level objects
            for secondLevelItem in colors {
                //set the any object to be an dictionary
                //and convert the values to usable objects
                guard let secondObj = secondLevelItem as? [String: Any],
                let description = secondObj["desription"] as? String,
                let color = secondObj["color"] as? String
                    else {continue}
                //Add item to the color array
                colorsArray.append(Colors(description: description, color: color))
            }
            //check to see if the revene item is null
            if let revene = obj["daily_revene"] as? String {
                //Use the convienence init to add new company to the array
                infoArray.append(companyInfo(catchPhrase: catchPhrase, colors: colorsArray, reveneString: revene))
            } else {
                //use init without adding a revene to add company to array
                infoArray.append(companyInfo(catchPhrase: catchPhrase, colors: colorsArray))
            }
        }
        //Display data to ui
        display(company: companies[currentIndex], info: infoArray[currentIndex])
    }
    
    //Create action to change the the currentIndex
    @IBAction func CurrentIndexChanged(_ sender: UIButton) {
        //Change the index based on the button's tag
        currentIndex += sender.tag
        
        //Check to see if they are past the the first or last company
        if currentIndex < 0 {
            //set the index to the last company
            currentIndex = companies.count - 1
        } else if currentIndex >= companies.count {
            //set the index to the first company
            currentIndex = 0
        }
        
        //display to the ui
        display(company: companies[currentIndex], info: infoArray[currentIndex])
    }
    
    //Create function to display the data to the ui
    func display(company: Company, info: companyInfo) {
        //make sure ui updates are all on the main thread
        DispatchQueue.main.async {
            self.lblName.text = company.name
            self.lblVersion.text = company.version
            self.lblCompany.text = company.company
            self.lblCatchPhrase.text = info.catchPhrase
            self.lblReneve.text = info.reveneString
            self.txtColors.text = info.colorString
        }
    }
}

