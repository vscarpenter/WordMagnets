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
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        view.backgroundColor = UIColor.blackColor()
        imageView.userInteractionEnabled = true
        
        var wordArray = ["I ","like ","to ","eat ","pizza", "my", "favorite"]
        
        for word in wordArray {
            var label = UILabel()
            label.font = UIFont.systemFontOfSize(36)
            label.text = word
            label.sizeToFit()
            
            var x = CGFloat(arc4random_uniform(300))
            var y = CGFloat(arc4random_uniform(400))
            
            label.center = CGPoint(x: x, y: y)
            label.backgroundColor = UIColor.whiteColor()
            imageView.addSubview(label)
            
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
    
    @IBAction func screenshotButtonPressed(sender: AnyObject) {
        println("screenshot pressed")
        var image = takeScreenshot(imageView)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func takeScreenshot(theView: UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(theView.bounds.size, true, 0.0)
        theView.drawViewHierarchyInRect(theView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    
    
}

