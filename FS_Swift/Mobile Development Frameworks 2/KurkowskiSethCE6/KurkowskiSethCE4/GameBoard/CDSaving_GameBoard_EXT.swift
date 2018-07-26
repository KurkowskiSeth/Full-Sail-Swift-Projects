//
//  CDSaving_GameBoard_EXT.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/18/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation
import CoreData

extension GameBoard_VC {
    
    func saveData() {
        highscores = NSEntityDescription.insertNewObject(forEntityName: "HighScores", into: managedContext)
        highscores.setValue(gameTime, forKey: "time")
        highscores.setValue(moves, forKey: "moves")
        highscores.setValue(userInitials, forKey: "name")
        highscores.setValue(Date(), forKey: "date")
        appDelegate.saveContext()
    }
    
    func startSaveingData() {
        highscores = NSManagedObject(entity: entityDescription, insertInto: managedContext)
        highscores.setValue(gameTime, forKey: "time")
        highscores.setValue(moves, forKey: "moves")
        highscores.setValue(userInitials, forKey: "name")
        highscores.setValue(Date(), forKey: "date")
        appDelegate.saveContext()
    }
    
    
}
