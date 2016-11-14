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
    ///
    var stringTimesSet = [String](repeating: " ", count: 1440)//for 1 min frequency in one day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConstraintSlider()
        //mapViewOutlet.isHidden = true
        //sliderOutlet.transform = CGAffineTransform.init(rotationAngle: CGFloat(CFloat(-M_PI/2)))
        sliderValue = Int(sliderOutlet.value)
        labelOutlet.text = String(describing: sliderValue!)
        
        // 
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest // location coordinates accuracy
        locationManager?.requestWhenInUseAuthorization() // ask user for hes private location
        locationManager?.startMonitoringSignificantLocationChanges() // track current location changes
        //mapViewOutlet.mapType = MKMapType.hybridFlyover
       
    }
    override func viewWillAppear(_ animated: Bool) {
        // in individual thread
        let interval = SettingsData.sharedInstance.timerInterval
        if SettingsData.sharedInstance.setTracking{
            
            trackingTimer = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target:self, selector: #selector(MainVC.saveCoordinates), userInfo: nil, repeats: true)
            
        } else {
            if trackingTimer != nil {
            trackingTimer.invalidate()
               }
        }
        
        if SettingsData.sharedInstance.assignedDate !== nil {
          
            let startDate = dateCasting(acceptedDate: SettingsData.sharedInstance.assignedDate!).0
            let endDate = dateCasting(acceptedDate: SettingsData.sharedInstance.assignedDate!).1
            getCoordinates(rangeStartDate: startDate!, rangeEndDate: endDate!)
            
        
        } else {
            
            let todayDate = NSDate()
            let startDate = dateCasting(acceptedDate: todayDate).0
            let endDate = dateCasting(acceptedDate: todayDate).1
            getCoordinates(rangeStartDate: startDate!, rangeEndDate: endDate!)
            
        }
   
    }
    
    @IBAction func sliderSlide(_ sender: UISlider) {
       
        sliderValue = Int(sliderOutlet.value)
        if (!mapViewOutlet.annotations.isEmpty) {
            let annotation = mapViewOutlet.annotations[sliderValue!]
            mapViewOutlet.centerCoordinate = annotation.coordinate
            labelOutlet.text = String(describing: stringTimesSet[sliderValue!])
        } else {
            labelOutlet.text = ""
        }
    }

    @IBAction func exitAction(_ sender: UIBarButtonItem) {
        exit(0)
    }
    func ConstraintSlider(){
        self.view.removeConstraints(sliderOutlet.constraints)
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
    
    func getCoordinates(rangeStartDate: NSDate, rangeEndDate: NSDate){
     stringTimesSet.removeAll()
     mapViewOutlet.removeAnnotations(self.mapViewOutlet.annotations)
     let fetchRequest: NSFetchRequest<TrackingTime> = TrackingTime.fetchRequest()
     fetchRequest.predicate = NSPredicate(format: "(timeStamp >= %@) AND (timeStamp <= %@)", rangeStartDate as NSDate, rangeEndDate as NSDate)
     do {
     
       
            let results = try context.fetch(fetchRequest)
        
     var i = 0
     if results.count>0 {
     repeat {
     let resultsDate = results[i].timeStamp as NSDate?
     let resultsLatitude = results[i].latitude as Double?
     let resultsLongitude = results[i].longitude as Double?
     print("\(resultsDate):\(resultsLatitude):\(resultsLongitude):\(results.count)")
     i+=1
     stringTimesSet.append(getStringTime(acceptedDate: resultsDate!))
     print(getStringTime(acceptedDate: resultsDate!))
     let pin = MKPointAnnotation()
     
     pin.coordinate.latitude = resultsLatitude!
     pin.coordinate.longitude = resultsLongitude!
     pin.title = "point\(i)"
     mapViewOutlet.addAnnotation(pin)
     
     } while (i<results.count)
        sliderOutlet.minimumValue = 0
        sliderOutlet.maximumValue = Float(mapViewOutlet.annotations.count) - 1
     }
        
     } catch{
     
     let error = error as NSError
     print("\(error)")
     
     }
     
     }

    
    func dateCasting(acceptedDate: NSDate) -> (NSDate?,NSDate?){
        
        let castingDate = acceptedDate
        let castingCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let castingDateComponents = NSDateComponents()
        castingDateComponents.timeZone = TimeZone.current
        castingDateComponents.day = (castingCalendar?.component(.day, from: castingDate as Date))!
        castingDateComponents.month = (castingCalendar?.component(.month, from: castingDate as Date))!
        castingDateComponents.year = (castingCalendar?.component(.year, from: castingDate as Date))!
        castingDateComponents.hour = 3
        castingDateComponents.minute = 0
        castingDateComponents.second = 0
        let firstDate = castingCalendar?.date(from: castingDateComponents as DateComponents)
        castingDateComponents.hour = 27
        let secondDate = castingCalendar?.date(from: castingDateComponents as DateComponents)
        print("FirstDate:" + String(describing: firstDate))
        print("SecondDate:" + String(describing: secondDate))

    return (firstDate as NSDate?, secondDate as NSDate?)
    
    }
    
    func getStringTime(acceptedDate: NSDate) -> (String){
        
        let dateString = "\(acceptedDate)"
        let dateStringArray = dateString.components(separatedBy: " ")
        
        return dateStringArray[1]
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
            print("Date:" + String(describing: date))
            print("AssignedDate:" + String(describing: SettingsData.sharedInstance.assignedDate))
            print("Switch_state:\(SettingsData.sharedInstance.setTracking)")
            if #available(iOS 10.0, *) {
                trackingTime = TrackingTime(context: context)
            } else {
                // Fallback on earlier versions
            }
            trackingTime.timeStamp = date
            trackingTime.latitude = Double((localCoordinate?.latitude)!)
            trackingTime.longitude = Double((localCoordinate?.longitude)!)
            ad.saveContext()
            
            
        }
    }
}

