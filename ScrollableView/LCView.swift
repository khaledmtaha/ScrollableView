//
//  LCView.swift
//  ScrollableView
//
//  Created by Khaled Taha on 9/30/15.
//  Copyright (c) 2015 Khaled Taha. All rights reserved.
//

import UIKit



class LCView:UIView {
    
    var headerLabel:UILabel!
    var headerLabelFont = UIFont(name: "Helvetica", size: 16)
    var headerYConstraint:NSLayoutConstraint!
    var headerXConstraint:NSLayoutConstraint!
    
    var subTextLabel:UILabel!
    var subTextLabelFont = UIFont(name: "Helvetica-Light", size: 12)
    var subTextYConstraint:NSLayoutConstraint!
    var subTextXConstraint:NSLayoutConstraint!
    
    var headerFrame:CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit () {
        
        // Scroll View
        
        
        
        // Header Label
        
        headerLabel = UILabel()
        headerLabel.backgroundColor = UIColor.clearColor()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.numberOfLines = 3
        headerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        headerLabel.font = headerLabelFont
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.textAlignment = NSTextAlignment.Center
        
        self.insertSubview(headerLabel, atIndex: 0)
        
        headerYConstraint = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.addConstraint(headerYConstraint)
        
        headerXConstraint = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(headerXConstraint)
        
        ConstraintFactory.setWidthWithConstant(headerLabel, constant: 200)
        ConstraintFactory.setHeightWithConstant(headerLabel, constant: 50)
        
        subTextLabel = UILabel()
        subTextLabel.backgroundColor = UIColor.clearColor()
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subTextLabel.numberOfLines = 3
        subTextLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        subTextLabel.font = subTextLabelFont
        subTextLabel.textColor = UIColor.whiteColor()
        subTextLabel.textAlignment = NSTextAlignment.Center
        
        self.insertSubview(subTextLabel, atIndex: 0)
        
        subTextYConstraint = NSLayoutConstraint(item: subTextLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 40)
        self.addConstraint(subTextYConstraint)
        
        subTextXConstraint = NSLayoutConstraint(item: subTextLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(subTextXConstraint)
        
        ConstraintFactory.setWidthWithConstant(subTextLabel, constant: 200)
        ConstraintFactory.setHeightWithConstant(subTextLabel, constant: 50)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerFrame = headerLabel.frame
        
    }
    
}