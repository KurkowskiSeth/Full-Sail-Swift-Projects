//
//  DetailInterface.swift
//  KurkowskiSeth_CE02 WatchKit Extension
//
//  Created by Seth Kurkowski on 3/14/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class DetailInterface: WKInterfaceController {

    @IBOutlet var textLbl: WKInterfaceLabel!
    
    var profile: Profile? = nil
    
    override init() {
        super.init()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let contextDict = context as? [String : Any]
        profile = (contextDict!["context"] as? Profile)!
        if let profile = profile {
            print(profile.name + "\n" + profile.profileDescription)
            textLbl.setText(profile.name + "\n" + profile.profileDescription)
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
