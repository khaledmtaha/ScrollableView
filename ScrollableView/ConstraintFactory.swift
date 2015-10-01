//
//  ConstraintFactory.swift
//  ScrollableView
//
//  Created by Khaled Taha on 9/30/15.
//  Copyright (c) 2015 Khaled Taha. All rights reserved.
//

import UIKit



class ConstraintFactory {
    
    static func processConstraint (parentView:AnyObject, constraint:NSLayoutConstraint) {
        parentView.addConstraint(constraint)
    }
    
    // SIZE
    
    class func addEqualWidthConstraints (childObject:AnyObject, parentObject:AnyObject)  {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func addEqualHeightConstraints (childObject:AnyObject, parentObject:AnyObject)  {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func setWidthWithConstant (childObject:AnyObject, constant:CGFloat) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: constant)
        processConstraint(childObject, constraint: constraint)
    }
    
    class func setHeightWithConstant (childObject:AnyObject, constant:CGFloat) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: constant)
        processConstraint(childObject, constraint: constraint)
    }
    
    
    // POSITION
    
    class func centerX (childObject:AnyObject, parentObject:AnyObject) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func centerY (childObject:AnyObject, parentObject:AnyObject) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func setMinYfromCenter (childObject:AnyObject, parentObject:AnyObject, constant:CGFloat) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: constant)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func setMaxYfromBottom (childObject:AnyObject, parentObject:AnyObject, constant:CGFloat) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: constant)
        processConstraint(parentObject, constraint: constraint)
    }
    
    
    // ALIGN
    
    
    class func alignMinX (childObject:AnyObject, parentObject:AnyObject) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func alignMaxX (childObject:AnyObject, parentObject:AnyObject) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func alignMinY (childObject:AnyObject, parentObject:AnyObject) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: parentObject, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        processConstraint(parentObject, constraint: constraint)
    }
    
    // DISTRIBUTE
    
    class func distributeHorizontally (childObject:AnyObject, adjacentObject:AnyObject, parentObject:AnyObject, spacing:CGFloat) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: adjacentObject, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: spacing)
        processConstraint(parentObject, constraint: constraint)
    }
    
    class func distributeVertically (childObject:AnyObject, adjacentObject:AnyObject, parentObject:AnyObject, spacing:CGFloat) {
        let constraint = NSLayoutConstraint(item: childObject, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: adjacentObject, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: spacing)
        processConstraint(parentObject, constraint: constraint)
    }
    
    
}

