//
//  CustomTableViewCell.swift
//  GeniusPlazzaAssignment
//
//  Created by dinesh danda on 5/1/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit

class CustomTableviewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

