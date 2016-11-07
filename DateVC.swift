//
//  DateVC.swift
//  26Tracking
//
//  Created by Taras on 11/6/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit

class DateVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        SettingsData.sharedInstance.assignedDate = datePicker.date as NSDate?
        
    }
    

}
