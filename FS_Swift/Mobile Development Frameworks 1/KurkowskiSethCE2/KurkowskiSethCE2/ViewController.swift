//
//  ViewController.swift
//  KurkowskiSethCE2
//
//  Created by Seth Kurkowski on 8/30/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //properties
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblMacAddress: UILabel!
    @IBOutlet weak var lblCurrentTitle: UILabel!
    @IBOutlet weak var lblNumOfSkills: UILabel!
    @IBOutlet weak var txtSkills: UITextView!
    @IBOutlet weak var lblNumOfEmployers: UILabel!
    @IBOutlet weak var txtEmployers: UITextView!
    
    var employees = [Employee]()
    var currentEmployeeIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Get the path of the EmployeeData.json file
        if let path = Bundle.main.path(forResource: "EmployeeData", ofType: ".json") {
            //Create a url from the path we created for the file
            let url = URL(fileURLWithPath: path)
        
            do {
                //Take data using the url we created and turn it into bianary data
                let data = try Data.init(contentsOf: url)
                
                //Serialize the data and cast into an array of any objects.
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                //Now parse through the data to create data objects.
                Parse(jsonObject: jsonObj)
                
                //Display the data to the view
                displayData()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Create a function to parse through the data
    func Parse(jsonObject: [Any]?){
        //Check to see that the jsonObject is not nill
        guard let json = jsonObject
            else {print("Failed to unwrap optional"); return}
        
        //loop through first level items in thejsonObject
        for firstLevelItem in json {
            //Try to set the first item into a dictionary
            guard let obj = firstLevelItem as? [String: Any],
            //Set each item in the obj dictionary
            let name = obj["employeename"] as? String,
            let username = obj["username"] as? String,
            let macaddress = obj["macaddress"] as? String,
            let title = obj["current_title"] as? String
                else {continue}
            
            //Check to see if array of skills if not empty
            if let skills = obj["skills"] as? [String] {
                //This will run if the employee has entered skills
                //Now check to see if there is an array of employers
                if let employers = obj["past_employers"] as? [Any] {
                    //This will run if both arrays have values
                    //Create an empty array of employers to add to the employee class once this is done.
                    var employersArray = [Employers]()
                    //Loop through each second level object
                    for secondLevelItem in employers {
                        //create another dictionary for the new object
                        guard let secondObj = secondLevelItem as? [String: Any],
                        let coName = secondObj["company"] as? String
                            else {continue}
                        //Check to see if there are values in the array of responsibilities
                        if let responsilities = secondObj["responsibilities"] as? [String] {
                            //this runs if ther are responsibilities
                            //Create a new employer object with responsibilities array and add to employers array
                            employersArray.append(Employers(company: coName, responsibilities: responsilities))
                        } else {
                            //this runs if there are no responsibilities
                            //Create a new empoyer object and add to employer array
                            employersArray.append(Employers(company: coName))
                        }
                    }
                    //create an employee object and add to employee array
                    employees.append(Employee(employeeName: name, username: username, macAddress: macaddress, currentTitle: title, skills: skills, employers: employersArray))
                } else {
                    //This should run if there is only an array of skills
                    //Create an employee object and add it to the array of employees
                    employees.append(Employee(employeeName: name, username: username, macAddress: macaddress, currentTitle: title, skills: skills))
                }
                
            } else {
                print("\t\(name) NOT ADDED TO ARRAY\n")
            }
            
//            for e in employees {
//                print(e.employeeName)
//                print("\tUsername: " + e.username)
//                print("\tMac Address: " + e.macAddress)
//                print("\tCurrent Title: " + e.currentTitle)
//                print("\tTotal Skills: " + e.numOfSkills.description)
//                for s in e.skills {
//                    print("\t" + s)
//                }
//                print("\tTotal Employers: " + e.numOfEmployers.description)
//                for p in e.employers {
//                    print("\tCompany: " + p.company)
//                    print("\tTotal Responsibilities: " + p.numOfResponsibilities.description)
//                    for r in p.responsibilities {
//                        print("\t\t" + r)
//                    }
//                }
//                print()
//            }
        }
    }
    //Action to move around in array based on button tags
    @IBAction func ChangeIndex(_ sender: UIButton) {
        //Add tag to the current index
        currentEmployeeIndex += sender.tag
        
        //check to see if the tag is less than 0
        if currentEmployeeIndex < 0 {
            //set the index to the last item in array
            currentEmployeeIndex = employees.count - 1
        }
        //Check to see if the index is larger than the last item in the array
        else if currentEmployeeIndex >= employees.count {
            //Set the the index to 0 to start from the beginning
            currentEmployeeIndex = 0
        }
        
        //Display the data to the screen
        displayData()
    }
    
    //function to display the employees data
    func displayData() {
        lblEmployeeName.text = employees[currentEmployeeIndex].employeeName
        lblUsername.text = employees[currentEmployeeIndex].username
        lblMacAddress.text = employees[currentEmployeeIndex].macAddress
        lblCurrentTitle.text = employees[currentEmployeeIndex].currentTitle
        lblNumOfSkills.text = employees[currentEmployeeIndex].numOfSkills.description
        txtSkills.text = employees[currentEmployeeIndex].skillString
        lblNumOfEmployers.text = employees[currentEmployeeIndex].numOfEmployers.description
        txtEmployers.text = employees[currentEmployeeIndex].employerString
    }


}

