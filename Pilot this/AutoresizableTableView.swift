//
//  AutoresizableTableView.swift
//  Pilot this
//
//  Created by Gustavo Villar on 3/28/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

class AutoresizableTableView: UITableView {
    var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1000, constant: 0)
        addConstraint(heightConstraint)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heightConstraint?.constant = self.contentSize.height
    }
}


