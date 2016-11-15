//
//  FrequencyVC.swift
//  26Tracking
//
//  Created by Taras on 11/8/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit

class FrequencyVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var frequencyTableView: UITableView!
    
    var frequencyTableViewCellNames: [String] = ["","3 sec","1 min", "5 min","10 min","15 min","30 min","1 hr"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frequencyTableView.delegate = self
        frequencyTableView.dataSource = self

   
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = Bundle.main.loadNibNamed("FrequencySpaceCell",
                                                owner: self,
                                                options: nil)?.first as!
                                                FrequencySpaceCell
            
            return cell
            
        } else {
            
            let cell = Bundle.main.loadNibNamed("FrequencyControlCell",
                                                owner: self,
                                                options: nil)?.first as!FrequencyControlCell
            cell.frequencyControlCellLabel.text = frequencyTableViewCellNames[indexPath.row]
            
            if cell.frequencyControlCellLabel.text == SettingsData.sharedInstance.activeCellName{
                
                cell.frequencyTickLabel.text = "✓"
                
            } else {
                
                cell.frequencyTickLabel.text = ""
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 50
            
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = frequencyTableView.cellForRow(at: indexPath) as?
            FrequencyControlCell {
            
            
            let cellName = cell.frequencyControlCellLabel.text
            SettingsData.sharedInstance.activeCellName = cellName!
            
            switch cellName! {
                
            case frequencyTableViewCellNames[1]:
                SettingsData.sharedInstance.timerInterval = 3
                print(cellName)
                break
            case frequencyTableViewCellNames[2]:
                SettingsData.sharedInstance.timerInterval = 60
                print(cellName)
                break
            case frequencyTableViewCellNames[3]:
                SettingsData.sharedInstance.timerInterval = 300
                print(cellName)
                break
            case frequencyTableViewCellNames[4]:
                SettingsData.sharedInstance.timerInterval = 600
                print(cellName)
                break
            case frequencyTableViewCellNames[5]:
                SettingsData.sharedInstance.timerInterval = 900
                print(cellName)
                break
            case frequencyTableViewCellNames[6]:
                SettingsData.sharedInstance.timerInterval = 1800
                print(cellName)
                break
            case frequencyTableViewCellNames[7]:
                SettingsData.sharedInstance.timerInterval = 3600
                print(cellName)
                break
                
            default:
                //
                print("No selected!")
                break
            }
            frequencyTableView.reloadData()
        }
        
        
    }

}
