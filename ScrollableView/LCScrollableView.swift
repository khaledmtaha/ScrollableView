//
//  LCScrollableView.swift
//  ScrollableView
//
//  Created by Khaled Taha on 9/30/15.
//  Copyright (c) 2015 Khaled Taha. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case Left, Right, None
    func direction() -> String {
        switch self {
        case .Left:
            return "Left"
        case .Right:
            return "Right"
        case .None:
            return "None"
        }
    }
}


class LCScrollableView:UIScrollView {
    
    var viewA:LCView!
    var viewB:LCView!
    var viewC:LCView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    private func commonInit() {
        
        self.backgroundColor = UIColor.clearColor()
        self.bounces = false
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = true
        self.showsVerticalScrollIndicator = true
        
        viewA = LCView()
        viewA.headerLabel.text = "Lorem ipsum dolor sit amet"
        viewA.subTextLabel.text = "Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        viewA.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.insertSubview(viewA, atIndex: 0)
        
        viewB = LCView()
        viewB.headerLabel.text = "Duis aute "
        viewB.subTextLabel.text = "Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        viewB.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.insertSubview(viewB, atIndex: 0)
        
        viewC = LCView()
        viewC.headerLabel.text = "Duis leo"
        viewC.subTextLabel.text = "Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc"
        viewC.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.insertSubview(viewC, atIndex: 0)
        
        ConstraintFactory.alignMinX(viewA, parentObject: self)
        ConstraintFactory.alignMinY(viewA, parentObject: self)
        ConstraintFactory.addEqualHeightConstraints(viewA, parentObject: self)
        ConstraintFactory.addEqualWidthConstraints(viewA, parentObject: self)
        
        ConstraintFactory.distributeHorizontally(viewB, adjacentObject: viewA, parentObject: self, spacing: 0)
        ConstraintFactory.alignMinY(viewB, parentObject: self)
        ConstraintFactory.addEqualHeightConstraints(viewB, parentObject: self)
        ConstraintFactory.addEqualWidthConstraints(viewB, parentObject: self)
        
        ConstraintFactory.distributeHorizontally(viewC, adjacentObject: viewB, parentObject: self, spacing: 0)
        ConstraintFactory.alignMaxX(viewC, parentObject: self)
        ConstraintFactory.alignMinY(viewC, parentObject: self)
        ConstraintFactory.addEqualHeightConstraints(viewC, parentObject: self)
        ConstraintFactory.addEqualWidthConstraints(viewC, parentObject: self)
        
        self.layoutIfNeeded()
        
    }
    
    func setRandomBGColor () -> (UIColor) {
        return UIColor(red: randomRBG(), green: randomRBG(), blue: randomRBG(), alpha: 1)
    }
    
    func randomRBG () -> CGFloat {
        return CGFloat(arc4random_uniform(100))/100
    }
    
    func createGrid () {
        let frame = self.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        let pixelIncrement:CGFloat = 10
        let amountOfGridPoints = frame.width/pixelIncrement
        
        var index:CGFloat = 0
        
        for index = 0; index < amountOfGridPoints; ++index {
            let gridView = UIView(frame: CGRectMake(index * pixelIncrement, 400, 2, 10))
            gridView.backgroundColor = UIColor.redColor()
            self.addSubview(gridView)
            
            
        }
    }
}



