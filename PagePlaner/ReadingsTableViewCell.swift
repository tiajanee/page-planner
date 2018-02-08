//
//  ReadingsTableViewCell.swift
//  PagePlaner
//
//  Created by Tia King on 2/8/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit

class ReadingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
        cellBackground.layer.borderColor = UIColor.white.cgColor
        cellBackground.layer.borderWidth = 0.50
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
