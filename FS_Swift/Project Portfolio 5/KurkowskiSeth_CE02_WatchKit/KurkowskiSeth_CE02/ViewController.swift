//
//  ViewController.swift
//  KurkowskiSeth_CE02
//
//  Created by Seth Kurkowski on 3/13/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate {
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var profiles: [Profile] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profiles = createDataModel()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = profiles[indexPath.row].name
        return cell
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if (message["getProfiles"] as? Bool) != nil {
                NSKeyedArchiver.setClassName("Profile", for: Profile.self)
                let data = NSKeyedArchiver.archivedData(withRootObject: self.profiles)
                replyHandler(["Profiles" : data])
            }
        }
    }


}

