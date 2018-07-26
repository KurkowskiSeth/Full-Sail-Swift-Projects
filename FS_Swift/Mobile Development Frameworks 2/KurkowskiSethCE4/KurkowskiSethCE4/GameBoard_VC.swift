//
//  GameBoard_VC.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/10/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class GameBoard_VC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeToBeatLbl: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var resumeBtn: UIButton!
    @IBOutlet var cards: [CardAnimations]!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var extraCards: [CardAnimations]!
    
    //MARK: -Properties
    var countdownTime = 5
    var countdownTimer: Timer? = nil
    var gameTime = 0
    var gameTimer: Timer? = nil
    var selectedCards = [UIButton]()
    var freezeTimer: Timer? = nil
    var matchTimer: Timer? = nil
    var matches = [CardAnimations]()
    let defults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in cardButtons {
            i.adjustsImageWhenDisabled = false
        }
        
        //Set timeToBeatLbl
        let timeToBeat = defults.integer(forKey: "timeToBeat")
        timeToBeatLbl.text = String(format: "%d:%02d", timeToBeat / 60, timeToBeat % 60)
        
        //Add extra cards for ipad size class
        if UIDevice.current.userInterfaceIdiom == .pad && cards.count != 30 {
            for i in extraCards {
                cards.append(i)
            }
        }
        
        shuffleCards()
        
        //Start countdown
        countdownSetUp()
    }
    
    //MARK: -Pause and Resume Game Timer
    @IBAction func pauseResumeTimer(_ sender: UIButton) {
        if gameTimer == nil {
            //Restart timer
            gameTimeSetUp()
            
            //Display pauseBtn
            pauseBtn.isHidden = false
            resumeBtn.isHidden = true
        }
        else {
            //Stop timer
            gameTimer?.invalidate()
            gameTimer = nil
            
            //Display resumeBtn
            resumeBtn.isHidden = false
            pauseBtn.isHidden = true
        }
    }
    
    //MARK: -Show Card
    @IBAction func showCard(_ sender: UIButton) {
        if selectedCards.count != 2 {
            //Place the buttons into the selectedCards array
            selectedCards.append(sender)
            
            //Hide the button
            sender.isHidden = true
            
            //Check to see if there are two selected cards
            if selectedCards.count == 2 {
                
                //Check to see if the the images match
                if cards[selectedCards[0].tag].image == cards[selectedCards[1].tag].image {
                    
                    //Add to matches array
                    matches.append(cards[selectedCards[0].tag])
                    matches.append(cards[selectedCards[1].tag])
                    
                    //Set up match timer
                    matchTimerSetUp()
                    
                    //Perform animations
                    cards[selectedCards[0].tag].matched()
                    cards[selectedCards[1].tag].matched()
                }
                else {
                    
                    //Shake cards
                    cards[selectedCards[0].tag].shake()
                    cards[selectedCards[1].tag].shake()
                    
                    //Disable all card buttons
                    for i in cardButtons {
                        i.isEnabled = false
                    }
                    
                    //Start freezeTimer
                    freezeTimerSetUp()
                }
            }
        }
    }
    
    //MARK: -Game Over Alert
    func gameOver() {
        //Check to see if the current time is lower than the fastest
        if defults.integer(forKey: "timeToBeat") == 0 || gameTime < defults.integer(forKey: "timeToBeat") {
            defults.set(gameTime, forKey: "timeToBeat")
        }
        
        let alert = UIAlertController(title: "Congrats, You Won!", message: "Time: \(currentTimeLabel.text!)", preferredStyle: .alert)
        
        let goBackBtn = UIAlertAction(title: "Main Menu", style: .default) { (_) in
            self.performSegue(withIdentifier: "unwindToRoot", sender: nil)
            alert.dismiss(animated: true, completion: nil)
        }
        
        let replayBtn = UIAlertAction(title: "Replay", style: .default) { (_) in
            //Recall viewDidLoad
            for i in self.cards {
                i.isHidden = false
            }
            self.matches.removeAll()
            self.gameTime = 0
            self.countdownTime = 5
            self.viewDidLoad()
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(goBackBtn)
        alert.addAction(replayBtn)
        
        present(alert, animated: true, completion: nil)
    }
    
}
