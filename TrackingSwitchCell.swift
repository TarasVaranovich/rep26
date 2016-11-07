//
//  TrackingSwitchCell.swift
//  26Tracking
//
//  Created by Taras on 11/6/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit

class TrackingSwitchCell: UITableViewCell {

    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBAction func changeSwitchState(_ sender: UISwitch) {
        
        if switchOutlet.isOn{
        
            SettingsData.sharedInstance.setTracking = true
        
        } else {
        
            SettingsData.sharedInstance.setTracking = false
            
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        switchOutlet.isOn = SettingsData.sharedInstance.setTracking
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
