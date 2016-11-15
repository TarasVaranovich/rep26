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
    
    @IBOutlet weak var startRangeDatePicker: UIDatePicker!
    @IBOutlet weak var endRangeDatePicker: UIDatePicker!
    @IBOutlet weak var stackViewOutlet: UIStackView!
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
  
        let startDate = startRangeDatePicker.date
        let endDate = endRangeDatePicker.date
        
        let fetchRequest: NSFetchRequest<TrackingTime> = TrackingTime.fetchRequest()
        fetchRequest.predicate = NSPredicate(format:
                                             "(timeStamp >= %@) AND (timeStamp <= %@)",
                                             startDate as NSDate,
                                             endDate as NSDate)

        do {
            
            let results = try context.fetch(fetchRequest)
            var i = 0
            
            if results.count > 0 {
                
            repeat {
                
                    context.delete(results[i])
                    ad.saveContext()
                    print("Item\(i) is deleted. Range:\(startDate):\(endDate)")
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        view.contentMode = .redraw
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            stackViewOutlet.axis = .horizontal
            
        } else {
            
            stackViewOutlet.axis = .vertical
        
        }
    }
}
