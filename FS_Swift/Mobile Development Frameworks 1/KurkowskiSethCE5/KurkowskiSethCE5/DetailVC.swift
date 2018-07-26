//
//  DetailVC.swift
//  KurkowskiSethCE5
//
//  Created by Seth Kurkowski on 9/19/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var party: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var congressman: CongressData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //set ui elements
        if congressman != nil {
            fullName.text = congressman.fullName
            party.text = congressman.party
            state.text = congressman.stateName
        }
        
        //load the image of the selected congressman
        //create a configuaton for the url session
        let config = URLSessionConfiguration.default
        
        //create a url session
        let session = URLSession(configuration: config)
        
        //check to make sure the url is valid
        if let validURL = URL(string: "https://theunitedstates.io/images/congress/225x275/\(congressman.bioguideID).jpg"){
            
            //create task to download image
            let task = session.dataTask(with: validURL, completionHandler: { (data, response, error) in
                //check error
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                //check status code
                guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let savedData = data
                    else {print("Problem with DetailVC guard"); return}
                
                let congressImage = UIImage(data: savedData)
                
                //set the image
                DispatchQueue.main.async {
                    self.imageView.image = congressImage
                }
            })
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
