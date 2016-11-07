//
//  ViewController.swift
//  26Tracking
//
//  Created by Taras on 11/5/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class MainVC: UIViewController , CLLocationManagerDelegate{
    
    @IBOutlet weak var mapViewOutlet: MKMapView!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var labelOutlet: UILabel!
    var K : CGFloat = 0.7
    var sliderValue: Int? = nil
    var locationManager:CLLocationManager? = nil
    var trackingTimer: Timer!
    ///
    var trackingTime: TrackingTime!
   
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        ConstraintSlider()
        //sliderOutlet.transform = CGAffineTransform.init(rotationAngle: CGFloat(CFloat(-M_PI/2)))
        sliderValue = Int(sliderOutlet.value)
        labelOutlet.text = String(describing: sliderValue!)
        // declare variables
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if SettingsData.sharedInstance.setTracking{
            trackingTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(MainVC.saveCoordinates), userInfo: nil, repeats: true)
        } else {
            if trackingTimer != nil {
            trackingTimer.invalidate()
               }
        }
        //saveCoordinates()
        getCoordinates()
    }
    
    @IBAction func sliderSlide(_ sender: UISlider) {
        sliderValue = Int(sliderOutlet.value)
        labelOutlet.text = String(describing: sliderValue!)

    }

    @IBAction func exitAction(_ sender: UIBarButtonItem) {
        exit(0)
    }
    func ConstraintSlider(){
        sliderOutlet.removeConstraints(sliderOutlet.constraints)
        let widthS = NSLayoutConstraint(item:sliderOutlet,
                                           attribute:NSLayoutAttribute.width,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: view,
                                           attribute: NSLayoutAttribute.height,
                                           multiplier:K,
                                           constant:0)
        let trailingS = NSLayoutConstraint(item:sliderOutlet,
                                           attribute:NSLayoutAttribute.centerX,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: view,
                                           attribute: NSLayoutAttribute.centerX,
                                           multiplier:2.0,
                                           constant:-20)
        trailingS.isActive = true
        widthS.isActive = true
        self.view.addConstraints([trailingS, widthS])
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        ConstraintSlider()
        view.contentMode = .redraw
    }
    
    func getCoordinates(){
        let fetchRequest: NSFetchRequest<TrackingTime> = TrackingTime.fetchRequest()
        //let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context ,sectionNameKeyPath: nil , cacheName:nil)
        
        do {
            
            let results = try context.fetch(fetchRequest)//try controller.performFetch()
            for i in 0...results.count - 1 {
                let resultsDate = results[i].timeStamp as NSDate?
                let resultsLatitude = results[i].latitude as Double?
                let resultsLongitude = results[i].longitude as Double?
                print("\(resultsDate):\(resultsLatitude):\(resultsLongitude)")
            
            }
            
        } catch{
            
            let error = error as NSError
            print("\(error)")
            
        }
      
        
        /*let pin = MKPointAnnotation()
        
        //pin.coordinate = localCoordinate!
        pin.title = "point\(1)"
        mapViewOutlet.addAnnotation(pin)*/
        
    }
    
    func saveCoordinates(){
        //get current coordinates
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
            let localCoordinate = locationManager?.location?.coordinate
            print("Coordinates:\(Double((localCoordinate?.latitude)!))\(Double((localCoordinate?.longitude)!))")
            //get current date
            //print("hours = \(hour):\(minutes):\(seconds)")
            let date = NSDate()
            //let calendar = NSCalendar.current
           
            //let dateFormatter = DateFormatter()
            //dateFormatter.dateFormat = "dd MMM yyyy"
            print("Date:" + String(describing: date))
            print("AssignedDate:" + String(describing: SettingsData.sharedInstance.assignedDate))
            print("Switch_state:\(SettingsData.sharedInstance.setTracking)")
            
            trackingTime = TrackingTime(context: context)
            trackingTime.timeStamp = date
            trackingTime.latitude = Double((localCoordinate?.latitude)!)
            trackingTime.longitude = Double((localCoordinate?.longitude)!)
            
            
            ad.saveContext()
            
            
        }
    }
}

