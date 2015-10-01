//
//  LCPageView.swift
//  PageControl
//
//  Created by Khaled Taha on 9/29/15.
//  Copyright (c) 2015 Khaled Taha. All rights reserved.
//

/*

https://github.com/RidgeCorn/RCPageControl
https://github.com/yoavlt/LiquidFloatingActionButton

*/

import UIKit
import QuartzCore


class LCPageControl : UIControl {
    
    // MARK: Property
    
    var numberOfPages: Int = 0
    
    var currentPage:Int = 1 {
        didSet {
            setCurrentPageWithAnimation(currentPage)
        }
    }
    
    var indicatorWidth: CGFloat = 5 {
        didSet {
            indicatorHeight = indicatorWidth

        }
    }
    
    var indicatorHeight: CGFloat = 5 {
        didSet {

            indicatorWidth = indicatorHeight
        }
    }
    
    var indicatorSpacing: CGFloat = 5
    
    var inactiveColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            if inactiveColor == highlightedColor {
                println("Inactive color is the same as Highlighted color")
            }
            

        }
    }
    
    var highlightedColor:UIColor = UIColor.darkGrayColor() {
        didSet {
            if highlightedColor == inactiveColor {
                println("Inactive color is the same as Highlighted color")
            }
            

        }
    }
    
    var activeViewTag : Int?
    
    var animationScale : CGFloat = 1.2
    
    var duration:CFTimeInterval = 0.4
    
    var drawAssetsCount:Int = 0
    
    // MARK: Initializers
    
    init() {
        super.init(frame: CGRectZero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        setup()
    }
    
    func comeAlive () {
        self.currentPage = 1
    }
    
    // MARK: Properties
    
    func setup() {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userInteractionEnabled = true
    }
    
    func drawAssets() {
        
        // Objective: To draw the beginning state of the control as illustrated below
        
        /*
        
        (i) Illustration of the desired control
        
        |---gap---indicator---gap---indicator---gap---|
        
        |----|-----hitbox------|-----hitbox------|----|
        
        */
        
        
        // Step 1: Determine the dimensions for the container that houses the control
        
        let numberOfGaps = numberOfPages + 1
        
        let totalIndicatorWidth = CGFloat(numberOfPages) * indicatorWidth
        let totalGapWidth = CGFloat(numberOfGaps) * indicatorSpacing
        let totalContainerWidth = totalIndicatorWidth + totalGapWidth
        let totalContainerHeight = indicatorHeight
        let containerBegX = (bounds.width - totalContainerWidth)/2
        let containerBegY = (bounds.height - totalContainerHeight)/2
        
        // Step 2: Iterate the loop adding all the views used in the controls
        
        for var i = 0; i < numberOfPages; i++ {
            
            // Step 2(a): Determine the dimensions for subviews used in the control
            
            let numberOfGapsPrior = i + 1
            
            let totalIndicatorWidthOfViewsPreviouslyAdded = CGFloat(i) * indicatorWidth
            let totalIndicatorWidthOfGapsPreviouslyAdded = CGFloat(numberOfGapsPrior) * indicatorSpacing
            
            let subviewBegX = containerBegX + totalIndicatorWidthOfViewsPreviouslyAdded + totalIndicatorWidthOfGapsPreviouslyAdded
            let subviewBegY = containerBegY
            
            // Step 2(b): Add the subviews with the following properties and tag them for later interaction
            
            let currentSubview = UIView(frame: CGRectMake(subviewBegX, subviewBegY, indicatorWidth, indicatorHeight))
            currentSubview.layer.cornerRadius = indicatorWidth/2
            currentSubview.backgroundColor = inactiveColor
            currentSubview.viewWithTag(i)
            
            self.addSubview(currentSubview)
        }
    }
    
    // MARK: Touch Methods
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        // Objective: Detect where touches ended to determine which indicator was presumably targeted
        
        if let touch = touches.first as? UITouch {
            let location = touch.locationInView(self)
            if let viewTag = tagForViewTouchedForPositionDetector(location) {
                animateToCurrentPage(viewTag)
                currentPage = viewTag + 1
            }
        }
        
        self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    func tagForViewTouchedForPositionDetector (location:CGPoint) -> Int? {
        
        // Step 1: Determine the dimensions for the container that houses the control
        
        /*
        
        (i) Illustration of the desired control
        
        |---gap---indicator---gap---indicator---gap---|
        
        |----|-----hitbox------|-----hitbox------|----|
        
        */
        
        let numberOfGaps = numberOfPages + 1
        
        let totalIndicatorWidth = CGFloat(numberOfPages) * indicatorWidth
        let totalGapWidth = CGFloat(numberOfGaps) * indicatorSpacing
        
        let totalContainerWidth = totalIndicatorWidth + totalGapWidth
        let totalContainerHeight = indicatorHeight
        
        let containerBegX = (bounds.width - totalContainerWidth)/2
        let containerEndY = bounds.width - containerBegX
        
        // Step 2: Determine the dimensions for the overall hitbox for the control
        
        let hitBoxBegX = containerBegX + indicatorSpacing/2
        let hitBoxEndX = containerEndY - indicatorSpacing/2
        let hitBoxWidth = hitBoxEndX - hitBoxBegX
        
        // Step 3: Determine where the touch was made and return the page number (if done outside the hitbox then return nil)
        
        var currentPage:Int?
        
        if location.x > hitBoxBegX && location.x < hitBoxEndX {
            let locationInHitBox = location.x - hitBoxBegX
            currentPage = Int(floor((Double(locationInHitBox/(indicatorWidth + indicatorSpacing)))))
        }
        
        return currentPage as Int?
    }
    
    // MARK: Non-touch methods
    
    func setCurrentPageWithAnimation(currentPage:Int) {
        
        let viewTag = currentPage - 1
        animateToCurrentPageByScrolling (viewTag)
        println(viewTag)
        
    }
    
    // MARK: Animations
    func animateToCurrentPageByScrolling (viewTag:Int) {
        
        // Step 1 : Indicate which indicator (if any) is active
        
        if let test = activeViewTag {
            
            // Step 1(a) : There had been a indicator previously active
            
            let previousActiveViewTag = activeViewTag // Set so that we can animate away the previous view
            let previousActiveView = self.subviews[previousActiveViewTag!] as! UIView
            let activeView = self.subviews[viewTag] as! UIView
            
            // Step 1(a)i : Determine if the same view is being animate from and to
            
            if activeView != previousActiveView {
                
                // Not the same view being animated from and to
                
                animateToActiveBlock(activeView, completion: { () -> () in
                    return
                })
                animateToInactiveBlock(previousActiveView, completion: { () -> () in
                    return
                })
                
                activeViewTag = viewTag
                
            } else {
                
                // The same view being animated from and to
                
                            }
            
            
            
        } else {
            
            // Step 1(b) : There has been NO indicator previously active
            
            // Animate the activeView
            
            let activeView = self.subviews[viewTag] as! UIView
            
            animateToActiveBlock(activeView, completion: { () -> () in
                return
            })
            
            activeViewTag = viewTag
            
        }
        
    }

    
    func animateToCurrentPage(viewTag:Int) {
        
        // Step 1 : Indicate which indicator (if any) is active
        
        if let test = activeViewTag {
            
            // Step 1(a) : There had been a indicator previously active
            
            let previousActiveViewTag = activeViewTag // Set so that we can animate away the previous view
            let previousActiveView = self.subviews[previousActiveViewTag!] as! UIView
            let activeView = self.subviews[viewTag] as! UIView
            
            // Step 1(a)i : Determine if the same view is being animate from and to
            
            if activeView != previousActiveView {
                
                // Not the same view being animated from and to
                
                animateToActiveBlock(activeView, completion: { () -> () in
                    return
                })
                animateToInactiveBlock(previousActiveView, completion: { () -> () in
                    return
                })
                
                activeViewTag = viewTag
                
            } else {
                
                // The same view being animated from and to
                
                animateSameViewBlock(activeView, finished: { () -> () in
                    return
                })
                
                activeViewTag = viewTag
            }
            
            
            
        } else {
            
            // Step 1(b) : There has been NO indicator previously active
            
            // Animate the activeView
            
            let activeView = self.subviews[viewTag] as! UIView
            
            animateToActiveBlock(activeView, completion: { () -> () in
                return
            })
            
            activeViewTag = viewTag
            
        }
        
    }
    
    func animateToActiveBlock (view:UIView, completion:()->()) {
        
        // Color
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = inactiveColor.CGColor
        colorAnimation.toValue = highlightedColor.CGColor
        colorAnimation.fillMode = kCAFillModeForwards
        
        // Scale
        
        let fromValue = view.bounds.size
        let toValue = CGSize(width: fromValue.width * animationScale, height: fromValue.height * animationScale)
        let sizeAnimation = CABasicAnimation(keyPath: "bounds.size")
        sizeAnimation.fromValue = NSValue(CGSize:fromValue)
        sizeAnimation.toValue = NSValue(CGSize:toValue)
        sizeAnimation.fillMode = kCAFillModeBoth
        sizeAnimation.removedOnCompletion = false
        
        
        // Corner Radius
        
        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = indicatorWidth/2
        cornerAnimation.toValue = (indicatorWidth * animationScale)/2
        
        
        // Add Group Animations
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [colorAnimation, sizeAnimation, cornerAnimation]
        groupAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.34, 0.01, 0.69, 1.37)
        groupAnim.duration = duration
        groupAnim.removedOnCompletion = false
        view.layer.addAnimation(groupAnim, forKey: "all")
        
        completion(view.layer.backgroundColor = highlightedColor.CGColor)
        completion(view.layer.bounds.size = CGSize(width: indicatorWidth * animationScale, height: indicatorWidth * animationScale))
        completion(view.layer.cornerRadius = (indicatorWidth * animationScale)/2)
        
    }
    
    func animateToInactiveBlock (view:UIView, completion:()->()) {
        
        // Color
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = highlightedColor.CGColor
        colorAnimation.toValue = inactiveColor.CGColor
        colorAnimation.fillMode = kCAFillModeForwards
        
        // Scale
        
        let fromValue = view.bounds.size
        let toValue = CGSize(width: fromValue.width / animationScale, height: fromValue.height / animationScale)
        let sizeAnimation = CABasicAnimation(keyPath: "bounds.size")
        sizeAnimation.fromValue = NSValue(CGSize:fromValue)
        sizeAnimation.toValue = NSValue(CGSize:toValue)
        sizeAnimation.fillMode = kCAFillModeBoth
        sizeAnimation.removedOnCompletion = false
        
        // Corner Radius
        
        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = (indicatorWidth * animationScale)/2
        cornerAnimation.toValue = indicatorWidth/2
        
        // Add Group Animations
        
        let groupAnim = CAAnimationGroup()
        groupAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.34, 0.01, 0.69, 1.37)
        groupAnim.animations = [colorAnimation, sizeAnimation,cornerAnimation]
        groupAnim.duration = duration
        groupAnim.removedOnCompletion = false
        view.layer.addAnimation(groupAnim, forKey: "all")
        
        completion(view.layer.backgroundColor = inactiveColor.CGColor)
        completion(view.layer.bounds.size = CGSize(width: indicatorWidth, height: indicatorWidth))
        completion(view.layer.cornerRadius = (indicatorWidth)/2)
        
        
    }
    
    func animateSameViewBlock (view:UIView, finished:()->()) {
        
        // Color
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = highlightedColor.CGColor
        colorAnimation.toValue = inactiveColor.CGColor
        colorAnimation.fillMode = kCAFillModeForwards
        
        // Add Group Animations
        
        let groupAnim = CAAnimationGroup()
        groupAnim.repeatCount = 1
        groupAnim.animations = [colorAnimation]
        groupAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.34, 0.01, 0.69, 1.37)
        groupAnim.duration = duration
        groupAnim.removedOnCompletion = false
//        view.layer.addAnimation(groupAnim, forKey: "all")
        
        finished(view.layer.backgroundColor = highlightedColor.CGColor)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if drawAssetsCount == 0 {
            drawAssets()
            ++drawAssetsCount
        }
        

    }
    
}


