//
//  ProductTableViewCell.swift
//  Pilot this
//
//  Created by Fernando Rios Garate on 3/4/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var picture: UIImageView!
    
    var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
                var blurEffect = UIBlurEffect(style: .Light)
        //        var vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        var blurView = UIVisualEffectView(effect: blurEffect)
        //        var vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        //        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        blurView.frame = CGRectMake(0, 0, frame.width, descriptionView.frame.height)
        //        vibrancyView.frame = blurView.frame
        blurView.frame = descriptionView.bounds
        println(blurView.frame)
        println(descriptionView.frame)
        //        blurView.center = chartView.center
        //        nameLabel.insertSubview(vibrancyView, atIndex: 0)
        
        descriptionView.backgroundColor = UIColor(white: 0, alpha: 0.25)
        descriptionView.insertSubview(blurView, atIndex: 0)
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
