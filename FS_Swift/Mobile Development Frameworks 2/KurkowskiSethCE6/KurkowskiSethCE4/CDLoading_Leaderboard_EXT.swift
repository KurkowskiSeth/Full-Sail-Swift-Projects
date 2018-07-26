//
//  CDLoading_Leaderboard_EXT.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/19/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation
import CoreData

extension Leaderboard_TVC {
    //Fetch data and return array of usable data
    func loadSavedData() -> [(time: Int?, name: String?, moves: Int?, date: Date?)] {
        var returnArray = [(Int?, String?, Int?, Date?)]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "HighScores")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for obj in results {
                managedObject = obj
                
                let time = obj.value(forKey: "time") as? Int
                let name = obj.value(forKey: "name") as? String
                let moves = obj.value(forKey: "moves") as? Int
                let date = obj.value(forKey: "date") as? Date
                
                returnArray.append((time, name, moves, date))
            }
        }
        catch {
            assertionFailure()
        }
        return returnArray
    }
}
