//
//  SettingsVC.swift
//  26Tracking
//
//  Created by Taras on 11/6/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var settingsTableView: UITableView!
    
    var tableCellNames: [String] = ["","Choose a day", "Set a Frequancy","Clear Data"]
    var tableCellSeguesNames: [String] = ["","chooseSegue", "frequencySegue","clearSegue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        ///---
//        self.settingsTableView.register(ControlCell.self, forCellReuseIdentifier: "contolCell")
//        let nib = UINib(nibName: "contolCell", bundle: nil)
//        self.settingsTableView.register(nib, forCellReuseIdentifier: "contolCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //describes a table columns count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 //describes a table lines count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = Bundle.main.loadNibNamed("TrackingSwitchCell", owner: self, options: nil)?.first as! TrackingSwitchCell
            
            return cell
        } else {
        
            let cell = Bundle.main.loadNibNamed("ControlCell", owner: self, options: nil)?.first as! ControlCell
            cell.controlCellLabel.text = tableCellNames[indexPath.row]
            return cell
     }
       
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            
            return 50
        
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableCellSeguesNames[indexPath.row] != ""{
        performSegue(withIdentifier: tableCellSeguesNames[indexPath.row] ,sender: nil)
        }

    }
}
