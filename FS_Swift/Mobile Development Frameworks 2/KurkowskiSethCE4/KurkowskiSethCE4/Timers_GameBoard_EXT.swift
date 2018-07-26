//
//  Timers_GameBoard_EXT.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/10/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation
import UIKit

extension GameBoard_VC {
    
    //MARK: -Countdown Set Up
    func countdownSetUp() {
        
        if countdownTimer == nil {
            currentTimeLabel.text = String(format: "%d:%02d", 0, countdownTime)
            
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimerFire), userInfo: nil, repeats: true)
        }
    }
    
    //Countdown callback
    @objc func countdownTimerFire() {
        if countdownTime > 0 {
            countdownTime -= 1
            currentTimeLabel.text = String(format: "%d:%02d", 0, countdownTime)
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            
            //Enable buttons
            for i in cardButtons {
                i.isEnabled = true
            }
            
            //Hide cards
            hideCards()
            
            //Start game time
            gameTimeSetUp()
        }
    }
    
    //MARK: -GameTimer Set Up
    func gameTimeSetUp() {
        if gameTimer == nil {
            currentTimeLabel.text = String(format: "%d:%02d", gameTime / 60, gameTime % 60)
            
            pauseBtn.isHidden = false
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerFire), userInfo: nil, repeats: true)
        }
    }
    
    //Game timer callback
    @objc func gameTimerFire() {
        if matches.count == cards.count {
            gameOver()
            gameTimer?.invalidate()
            gameTimer = nil
        } else {
            gameTime += 1
            currentTimeLabel.text = String(format: "%d:%02d", gameTime / 60, gameTime % 60)
        }
    }
    
    //MARK: - FreezeTimer Set Up
    func freezeTimerSetUp() {
        if freezeTimer == nil {
            freezeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(unfreezeButtons), userInfo: nil, repeats: false)
        }
    }
    
    //Freeze timer callback
    @objc func unfreezeButtons() {
        for i in selectedCards {
            i.isHidden = false
        }
        
        for i in cardButtons {
            i.isEnabled = true
        }
        
        //Clear selectedCards array
        selectedCards.removeAll()
        
        //Stop Timer
        freezeTimer?.invalidate()
        freezeTimer = nil
    }
    
    //MARK: -Match Timer Set Up
    func matchTimerSetUp() {
        if matchTimer == nil {
            matchTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(matchTimerFire), userInfo: nil, repeats: false)
        }
    }
    
    //Match Timer Callback
    @objc func matchTimerFire() {
        for i in selectedCards {
            cards[i.tag].isHidden = true
        }
        
        //Clear selectedCards array
        selectedCards.removeAll()
        
        //Stop timer
        matchTimer?.invalidate()
        matchTimer = nil
    }
}
