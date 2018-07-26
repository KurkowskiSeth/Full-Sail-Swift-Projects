//
//  SearchTableViewController_EXT.swift
//  KurkowskiSethCE7
//
//  Created by Seth Kurkowski on 9/25/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation

extension SearchTableViewController {
    
    //Download all data from json file
    func download() {
        let path = Bundle.main.path(forResource: "zips", ofType: ".json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
            guard let json = jsonObj
                else {print("Faild to unwrap jsonObj"); return}
            for flo in json {
                guard let obj = flo as? [String: Any],
                let city = obj["city"] as? String,
                let loc = obj["loc"] as? [Double],
                let pop = obj["pop"] as? Int,
                let stateID = obj["state"] as? String,
                let zip = obj["_id"] as? String
                    else {print("Error in json loop guard"); return}
                results.append(Results(city: city, loc: loc, pop: pop, stateID: stateID, zip: zip))
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
