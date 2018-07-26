//
//  CardAnimations.swift
//  KurkowskiSethCE4
//
//  Created by Seth Kurkowski on 10/10/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

class CardAnimations: UIImageView {
    
    
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.05
        
        animation.repeatCount = 5
        
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
    func matched() {
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.4
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - 50))
        
        self.layer.add(animation, forKey: "position")
    }

}
