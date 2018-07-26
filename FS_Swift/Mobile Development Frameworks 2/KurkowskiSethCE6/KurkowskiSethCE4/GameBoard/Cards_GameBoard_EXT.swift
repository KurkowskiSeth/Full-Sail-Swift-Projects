//
//  Cards_GameBoard_EXT.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/10/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

extension GameBoard_VC {
    
    //MARK: -Shuffle and Display Images
    func shuffleCards() {
        
        var baseImages: [UIImage] = []
        
        for i in 1...10 {
            baseImages.append(UIImage(named: "asset_\(i)")!)
            baseImages.append(UIImage(named: "asset_\(i)")!)
        }
        
        var shuffledImages = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: baseImages) as? [UIImage]
        
        var extraImages: [UIImage] = []
        
        for i in 11...15 {
            extraImages.append(UIImage(named: "asset_\(i)")!)
            extraImages.append(UIImage(named: "asset_\(i)")!)
        }
        
        let shuffledExtras = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: extraImages) as? [UIImage]
        
        shuffledImages = shuffledImages! + shuffledExtras!
        
        for card in cards {
            card.image = shuffledImages?[card.tag]
        }
    }
    
    //Hide the cards when the countdown ends
    func hideCards() {
        for i in cardButtons {
            i.isHidden = false
        }
    }
}
