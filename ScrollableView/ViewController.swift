//
//  ViewController.swift
//  ScrollableView
//
//  Created by Khaled Taha on 8/18/15.
//  Copyright (c) 2015 Khaled Taha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var pageControl = UIPageControl()
    var newView = LCScrollableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(newView)

        ConstraintFactory.centerX(newView, parentObject: self.view)
        ConstraintFactory.centerY(newView, parentObject: self.view)
        ConstraintFactory.addEqualWidthConstraints(newView, parentObject: self.view)
        ConstraintFactory.addEqualHeightConstraints(newView, parentObject: self.view)
        
        configurePageControl ()
        
        newView.delegate = self

        
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    func configurePageControl () {

        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.yellowColor()
        self.pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        self.view.addSubview(pageControl)
        
        self.pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        ConstraintFactory.centerX(self.pageControl, parentObject: self.view)
        ConstraintFactory.setMinYfromCenter(self.pageControl, parentObject: self.view, constant: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

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
    
    private func commonInit() {
        
        self.backgroundColor = UIColor.clearColor()
        self.bounces = false
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = true
        self.showsVerticalScrollIndicator = true
        
        viewA = LCView()
        viewA.textBox.text = "Box A"
        viewA.backgroundColor = setRandomBGColor()
        viewA.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.insertSubview(viewA, atIndex: 0)
        
        viewB = LCView()
        viewB.textBox.text = "Box B"
        viewB.backgroundColor = setRandomBGColor()
        viewB.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.insertSubview(viewB, atIndex: 0)
        
        viewC = LCView()
        viewC.textBox.text = "Box C"
        viewC.backgroundColor = setRandomBGColor()
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
        
        println(viewA.frame.size)
        
        


    }
    
    
    
    
    func setRandomBGColor () -> (UIColor) {
        return UIColor(red: randomRBG(), green: randomRBG(), blue: randomRBG(), alpha: 1)
    }
    
    func randomRBG () -> CGFloat {
        return CGFloat(arc4random_uniform(100))/100
    }
    
    func createGrid () {
        let frame = self.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        println(frame)
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


class LCView:UIView {
    
    var textBox:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit () {
        textBox = UILabel()
        textBox.backgroundColor = UIColor.redColor()
        textBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        textBox.text = "Hello, World"
        textBox.textColor = UIColor.whiteColor()
        textBox.textAlignment = NSTextAlignment.Center
    
        self.insertSubview(textBox, atIndex: 0)
        ConstraintFactory.centerX(textBox, parentObject: self)
        ConstraintFactory.centerY(textBox, parentObject: self)
        ConstraintFactory.setWidthWithConstant(textBox, constant: 200)
        ConstraintFactory.setHeightWithConstant(textBox, constant: 50)
        
    }
    
}

