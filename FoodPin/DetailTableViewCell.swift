//
//  DetailTableViewCell.swift
//  FoodPin
//
//  Created by Yimeng Zhou on 7/3/15.
//  Copyright (c) 2015 Yimeng Zhou. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell{
    
    @IBOutlet weak var fieldLabel:UILabel!
    
    @IBOutlet weak var valueLabel:UILabel!
    
    @IBOutlet var mapButton:UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
