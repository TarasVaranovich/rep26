//
//  TrackingTime+CoreDataProperties.swift
//  26Tracking
//
//  Created by Taras on 11/7/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import Foundation
import CoreData


extension TrackingTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackingTime> {
        return NSFetchRequest<TrackingTime>(entityName: "TrackingTime");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var timeStamp: NSDate?
    @NSManaged public var toTrackingDate: TrackingDate?

}
