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
    var lcPageControl = LCPageControl()
    var newView = LCScrollableView()
    
    var rNewViewA:CGFloat = 0
    var gNewViewA:CGFloat = 0
    var bNewViewA:CGFloat = 0
    var aNewViewA:CGFloat = 0
    
    var rNewViewB:CGFloat = 0
    var gNewViewB:CGFloat = 0
    var bNewViewB:CGFloat = 0
    var aNewViewB:CGFloat = 0
    
    var rNewViewC:CGFloat = 0
    var gNewViewC:CGFloat = 0
    var bNewViewC:CGFloat = 0
    var aNewViewC:CGFloat = 0
    
    var rDistanceAB:CGFloat = 0
    var gDistanceAB:CGFloat = 0
    var bDistanceAB:CGFloat = 0
    
    var rDistanceBC:CGFloat = 0
    var gDistanceBC:CGFloat = 0
    var bDistanceBC:CGFloat = 0
    
    var lastContentOffset:CGFloat?
    
    var currFrameA:CGRect!
    
    var lastPage:Int = 1
    
    var pageViewProtection:Bool = false
    
    var previousScrollViewPage:Int = 1
    
    var backgroundColorA = UIColor(red: 233/255, green: 71/255, blue: 37/255, alpha: 1)
    var backgroundColorB = UIColor(red: 1/255, green: 186/255, blue: 226/255, alpha: 1)
    var backgroundColorC = UIColor(red: 97/255, green: 187/255, blue: 70/255, alpha: 1)
 
    
//    var pageControlTouchAnimationsOnly:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)

        ConstraintFactory.centerX(newView, parentObject: self.view)
        ConstraintFactory.centerY(newView, parentObject: self.view)
        ConstraintFactory.addEqualWidthConstraints(newView, parentObject: self.view)
        ConstraintFactory.addEqualHeightConstraints(newView, parentObject: self.view)
        
        configurePageControl ()
        configureBGColor()
        
//        newView.bounces = true
        newView.delegate = self
        newView.showsHorizontalScrollIndicator = false
        newView.showsVerticalScrollIndicator  = false
        
        lcPageControl.addTarget(self, action: "pageControlValueChanged", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func getColor () {
        
        newView.viewA.backgroundColor?.getRed(&rNewViewA, green: &gNewViewA, blue: &bNewViewA, alpha: &aNewViewA)
        newView.viewB.backgroundColor?.getRed(&rNewViewB, green: &gNewViewB, blue: &bNewViewB, alpha: &aNewViewB)
        newView.viewC.backgroundColor?.getRed(&rNewViewC, green: &gNewViewC, blue: &bNewViewC, alpha: &aNewViewC)
        
        rDistanceAB = rNewViewA - rNewViewB
        gDistanceAB = gNewViewA - gNewViewB
        bDistanceAB = bNewViewA - bNewViewB
        
        rDistanceBC = rNewViewB - rNewViewC
        gDistanceBC = gNewViewB - gNewViewC
        bDistanceBC = bNewViewB - bNewViewC
        
        let distanceAB = (rDistanceAB, gDistanceAB, bDistanceAB)
        let distanceBC = (rDistanceBC, gDistanceBC, bDistanceBC)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        lcPageControl.comeAlive()
    }
    

    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offset = newView.contentOffset.x
        
        var size = newView.viewA.bounds.width
        var offsetToViewPercentage = offset/size
        var offsetToViewPercentageRounded = round(offsetToViewPercentage)

        var scrollDirection:ScrollDirection = ScrollDirection.None
        var modifier:CGFloat = 0
        
        var pageNumber = floor(offsetToViewPercentage + 1)
        var pageNumberRound = round(offsetToViewPercentage)+1
        
        if let test = lastContentOffset {
            if offset > lastContentOffset {
                scrollDirection = ScrollDirection.Right
            } else if offset < lastContentOffset {
                scrollDirection = ScrollDirection.Left
            }
        }
        
        if scrollDirection == ScrollDirection.Left {

        } else if scrollDirection == ScrollDirection.Right {
            
        }
        
        lastContentOffset = offset

        scrollAnimationOnColor(offset)
        
        if offsetToViewPercentage <= 0.5 {
            var normalizedRange = offsetToViewPercentage/0.5
            let alphaChange:CGFloat = 1
 
       
            newView.viewA.headerLabel.alpha = 1 - normalizedRange * alphaChange
            newView.viewA.subTextLabel.alpha = 1 - normalizedRange * alphaChange
            
            newView.viewB.headerLabel.alpha = 0
            newView.viewB.subTextLabel.alpha = 0
            
        } else if offsetToViewPercentage > 0.5 && offsetToViewPercentage <= 1.0 {
            var normalizedRange = (offsetToViewPercentage - 0.5)/0.5
            let alphaChange:CGFloat = 1
            
            newView.viewA.headerLabel.alpha = 0
            newView.viewA.subTextLabel.alpha = 0

            newView.viewB.headerLabel.alpha = 0 + normalizedRange * alphaChange
            newView.viewB.subTextLabel.alpha = 0 + normalizedRange * alphaChange
            
            newView.viewC.headerLabel.alpha = 0
            newView.viewC.subTextLabel.alpha = 0
            
        } else if offsetToViewPercentage > 1.0 && offsetToViewPercentage <= 1.5 {
            var normalizedRange = (offsetToViewPercentage - 1)/0.5
            let alphaChange:CGFloat = 1
            
            newView.viewB.headerLabel.alpha = 1 - normalizedRange * alphaChange
            newView.viewB.subTextLabel.alpha = 1 - normalizedRange * alphaChange
            
            newView.viewC.headerLabel.alpha = 0
            newView.viewC.subTextLabel.alpha = 0
            
        } else if offsetToViewPercentage > 1.5 && offsetToViewPercentage <= 2.0 {
            var normalizedRange = (offsetToViewPercentage - 1.5)/0.5

            let alphaChange:CGFloat = 1
            
            newView.viewB.headerLabel.alpha = 0
            newView.viewB.subTextLabel.alpha = 0

            newView.viewC.headerLabel.alpha = 0 + normalizedRange * alphaChange
            newView.viewC.subTextLabel.alpha = 0 + normalizedRange * alphaChange

        }
        
        
        // Page Indicator

        setPageIndicatorForScroll(offsetToViewPercentage)
        

        
        // Labels
            
        if offsetToViewPercentage <= 0.5 {
            var normalizedRange = offsetToViewPercentage/0.5
            
            newView.viewA.headerYConstraint.constant = -20 * normalizedRange
            newView.viewA.subTextYConstraint.constant = 40 + 20 * normalizedRange
            
            newView.viewA.headerXConstraint.constant = offset
            newView.viewA.subTextXConstraint.constant = offset
            
            
        } else if offsetToViewPercentage > 0.5 && offsetToViewPercentage <= 1.0 {
            var normalizedRange = (offsetToViewPercentage - 0.5)/0.5
            
            newView.viewB.headerYConstraint.constant = -20 + 20 * normalizedRange
            newView.viewB.subTextYConstraint.constant = 40 + 20 - 20 * normalizedRange
            
            newView.viewB.headerXConstraint.constant = offset - newView.viewA.bounds.width
            newView.viewB.subTextXConstraint.constant = offset - newView.viewA.bounds.width

            
        } else if offsetToViewPercentage > 1.0 && offsetToViewPercentage <= 1.5 {
            var normalizedRange = (offsetToViewPercentage - 1)/0.5
            
            newView.viewB.headerYConstraint.constant = -20 * normalizedRange
            newView.viewB.subTextYConstraint.constant = 40 + 20 * normalizedRange
            
            newView.viewB.headerXConstraint.constant = offset - newView.viewA.bounds.width
            newView.viewB.subTextXConstraint.constant = offset - newView.viewA.bounds.width
            
        } else if offsetToViewPercentage > 1.5 && offsetToViewPercentage <= 2.0 {
            var normalizedRange = (offsetToViewPercentage - 1.5)/0.5
            
            newView.viewC.headerYConstraint.constant = -20 + 20 * normalizedRange
            newView.viewC.subTextYConstraint.constant = 40 + 20 - 20 * normalizedRange
            
            newView.viewC.headerXConstraint.constant = offset - newView.viewA.bounds.width - newView.viewB.bounds.width
            newView.viewC.subTextXConstraint.constant = offset - newView.viewA.bounds.width - newView.viewB.bounds.width
            
            
        }
        
    
    }
    

    
    func scrollAnimationOnColor(offset:CGFloat) {
        var size = newView.viewA.bounds.width
        var offsetToViewPercentage = offset/size
        
        if offsetToViewPercentage < 1 {
            var normalizedRange = offsetToViewPercentage/1

            // A << >> B
            
            backgroundColorA.getRed(&rNewViewA, green: &gNewViewA, blue: &bNewViewA, alpha: &aNewViewA)
            backgroundColorB.getRed(&rNewViewB, green: &gNewViewB, blue: &bNewViewB, alpha: &aNewViewB)
            
            rDistanceAB = rNewViewA - rNewViewB
            gDistanceAB = gNewViewA - gNewViewB
            bDistanceAB = bNewViewA - bNewViewB
            
            
            let currentR = -rDistanceAB * normalizedRange + rNewViewA
            let currentG = -gDistanceAB * normalizedRange + gNewViewA
            let currentB = -bDistanceAB * normalizedRange + bNewViewA
            
            self.view.backgroundColor = UIColor(red: currentR, green: currentG, blue: currentB, alpha: 1)
            
            
            print("Phase A \(currentR * 255)")
            
            
            
            
        } else if offsetToViewPercentage > 1  {
            var normalizedRange = (offsetToViewPercentage - 1)

            
            // B << >> C
            
            backgroundColorB.getRed(&rNewViewB, green: &gNewViewB, blue: &bNewViewB, alpha: &aNewViewB)
            backgroundColorC.getRed(&rNewViewC, green: &gNewViewC, blue: &bNewViewC, alpha: &aNewViewC)
            
            rDistanceBC = rNewViewB - rNewViewC
            gDistanceBC = gNewViewB - gNewViewC
            bDistanceBC = bNewViewB - bNewViewC
            
            
            let currentR = -rDistanceBC * normalizedRange + rNewViewB
            let currentG = -gDistanceBC * normalizedRange + gNewViewB
            let currentB = -bDistanceBC * normalizedRange + bNewViewB
            
            self.view.backgroundColor = UIColor(red: currentR, green: currentG, blue: currentB, alpha: 1)

            print("Phase B \(currentR * 255)")

            
            

        } else {
            self.view.backgroundColor = backgroundColorB
            
        }
            
        
        
        
        
    }
    
    
    
    
    func configurePageControl () {

        self.lcPageControl.numberOfPages = 3
        self.view.insertSubview(lcPageControl, aboveSubview: pageControl)
        
        ConstraintFactory.centerX(self.lcPageControl, parentObject: self.view)
        ConstraintFactory.setMaxYfromBottom(self.lcPageControl, parentObject: self.view, constant: -50)
        ConstraintFactory.setHeightWithConstant(lcPageControl, constant: 10)
        ConstraintFactory.setWidthWithConstant(lcPageControl, constant: 40)

        self.lcPageControl.userInteractionEnabled = true
        
        
        
    }
    
    func configureBGColor () {

        self.view.backgroundColor = backgroundColorA
        
        
    }
    
    
    
    func pageControlValueChanged() {
        
      pageViewProtection = true
        
        if lastPage != lcPageControl.currentPage {

            let x = 320 * CGFloat(lcPageControl.currentPage - 1)
            var jumpX : CGFloat?
            
            if lcPageControl.currentPage == 1 {
                jumpX = 159
            } else if lcPageControl.currentPage == 2 {
                jumpX = 320 + 159
            } else {
                jumpX = 320 + 161
            }
            
            newView.setContentOffset(CGPoint(x: jumpX!, y: 0), animated: false)
            newView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            lastPage = lcPageControl.currentPage
        }

      
    }
    
    
    func setPageIndicatorForScroll(offsetToViewPercentage:CGFloat) {
        
    
        
        if offsetToViewPercentage <= 0.5 {
            if lcPageControl.currentPage != 1 {
                lcPageControl.currentPage = 1
            }


        } else if offsetToViewPercentage > 0.5 && offsetToViewPercentage <= 1.5 {
            if lcPageControl.currentPage != 2 {
                lcPageControl.currentPage = 2
            }


        } else if offsetToViewPercentage > 1.5 && offsetToViewPercentage <= 2.0 {
            if lcPageControl.currentPage != 3 {
                lcPageControl.currentPage = 3
            }

            
        }
        
    }
    
    func protectPageIndicator() {
        pageViewProtection = true
        
    }
    
    func unprotectPageView() {
        pageViewProtection = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


