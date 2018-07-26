//
//  ViewController.swift
//  KurkowskiSethCE9
//
//  Created by Seth Kurkowski on 9/20/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var view1: UIImageView!
    @IBOutlet weak var view2: UIImageView!
    @IBOutlet weak var view3: UIImageView!
    @IBOutlet weak var view4: UIImageView!
    @IBOutlet weak var view5: UIImageView!
    @IBOutlet weak var view6: UIImageView!
    @IBOutlet weak var view7: UIImageView!
    @IBOutlet weak var view8: UIImageView!
    let config = URLSessionConfiguration.default
    var session: URLSession? = nil
    var views = [(UIImageView, String)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        session = URLSession(configuration: config)
        views = [(view1, "https://goo.gl/Z1gsA6"), (view2, "https://goo.gl/5somTv"), (view3, "https://goo.gl/4VpKNR"), (view4, "https://goo.gl/XscrH9"), (view5, "https://goo.gl/K2Ygos"), (view6, "https://goo.gl/u3gTtY"), (view7, "https://goo.gl/iDhYzn"), (view8, "https://goo.gl/XR9Fip")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Actions

    @IBAction func regular(_ sender: UIButton) {
        for (view, pic) in views {
            view.image = download(pic: pic)
        }
    }
    
    @IBAction func serial(_ sender: UIButton) {
        //Create serial queue
        let serialQueue = DispatchQueue(label: "myserialqueue", qos: .userInitiated)
        serialQueue.async {
            //Loop through the array of views
            for (view, pic) in self.views {
                let savedImage = self.download(pic: pic)
                DispatchQueue.main.async {
                    view.image = savedImage
                }
            }
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        for (view, _) in views {
            view.image = nil
        }
    }
    
    @IBAction func Concurrent(_ sender: UIButton) {
        //Create a concurrent queue
        let concurrentQueue = DispatchQueue(label: "myconcurrentQueue", qos: .userInitiated, attributes: .concurrent)
        
            //loop through the array of ciews
            for (view, pic) in self.views {
                //start the queue
                concurrentQueue.async {
                let savedImage = self.download(pic: pic)
                DispatchQueue.main.async {
                    view.image = savedImage
                }
            }
        }
    }
    
    //func to download the picture
    func download(pic: String) -> UIImage {
        
        //set pic to be a valid url
        if let url = URL(string: pic) {
            
            //get the data from the url
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)!
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return #imageLiteral(resourceName: "Image")
    }

}
