//
//  ViewController.swift
//  WordMagnets
//
//  Created by Vinny Carpenter on 10/11/14.
//  Copyright (c) 2014 Vinny Carpenter. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController {
    
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        view.backgroundColor = UIColor.blackColor()
        var wordArray = ["Katie ","loves ","instagram ","mom ","dad", "youtube", "cookies"]
        
        for word in wordArray {
            var label = UILabel()
            label.font = UIFont.systemFontOfSize(36)
            label.text = word
            label.sizeToFit()
            
            var x = CGFloat(arc4random_uniform(300))
            var y = CGFloat(arc4random_uniform(400))
            
            label.center = CGPoint(x: x, y: y)
            label.backgroundColor = UIColor.whiteColor()
            view.addSubview(label)
            
            var panGesture = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
            
            label.addGestureRecognizer(panGesture)
            label.userInteractionEnabled = true
            
        }
    }
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        
        let tapPoint: CGPoint = sender.locationInView(view)
        
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        snap = UISnapBehavior(item: view, snapToPoint: tapPoint)
        animator.addBehavior(snap)
        
    }
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        var translation = panGesture.translationInView(view)
        panGesture.setTranslation(CGPointZero, inView: view)
        
        var label = panGesture.view as UILabel
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        
        
    }
    
}

