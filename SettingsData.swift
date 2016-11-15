//
//  SettingsData.swift
//  26Tracking
//
//  Created by Taras on 11/7/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import Foundation

class SettingsData { // singletone
    
    static var sharedInstance = SettingsData()
    private init(){}
    
    var assignedDate: NSDate? = nil
    var setTracking: Bool = false
    var activeCellName: String = "3 sec"
    var timerInterval: Int16 = 3
    
}
