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
    
    @IBOutlet weak var picture: UIImageView!
    
    var product: Product!
    
//    product 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
