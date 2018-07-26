//
//  InterfaceController.swift
//  KurkowskiSeth_CE02 WatchKit Extension
//
//  Created by Seth Kurkowski on 3/13/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var TableView: WKInterfaceTable!
    var profiles: [Profile] = []
    
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    var session: WCSession?
    
    override init() {
        super.init()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let myValues: [String : Any] = ["getProfiles" : true]
        if let session = session, session.isReachable {
            session.sendMessage(myValues, replyHandler: { (replyData) in                
                DispatchQueue.main.async {
                    if let data = replyData["Profiles"] as? Data {
                        NSKeyedUnarchiver.setClass(Profile.self, forClassName: "Profile")
                        if let profiles = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Profile] {
                            print(profiles)
                            self.profiles = profiles
                            self.TableView.setNumberOfRows(profiles.count, withRowType: "cell")
                            for p in profiles {
                                let index = profiles.index(of: p)
                                let row = self.TableView.rowController(at: index!) as? TableViewRows
                                row?.image.setImageNamed(p.image)
                            }
                        }
                    }
                }
            }, errorHandler: nil)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let segueContext = ["context": profiles[rowIndex]]
        return segueContext
    }
}
