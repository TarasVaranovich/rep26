//
//  FrequencyControlCell.swift
//  26Tracking
//
//  Created by Taras on 11/9/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit

class FrequencyControlCell: UITableViewCell {
    @IBOutlet weak var frequencyControlCellLabel: UILabel!

    @IBOutlet weak var frequencyTickLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
