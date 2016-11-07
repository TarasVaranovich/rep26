//
//  ClearDataVC.swift
//  26Tracking
//
//  Created by Taras on 11/7/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit
import CoreData

class ClearDataVC: UIViewController {
    var trackingTime: TrackingTime!
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        let fetchRequest: NSFetchRequest<TrackingTime> = TrackingTime.fetchRequest()
        
        do {
            
            let results = try context.fetch(fetchRequest)//try controller.performFetch()
            var i = 0
            if results.count>0{
            repeat {
                
                    context.delete(results[i])
                    ad.saveContext()
             print("Item\(i) is deleted.")
                i+=1
            } while (i < results.count)
          }
            
        } catch{
            
            let error = error as NSError
            print("\(error)")
            
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
