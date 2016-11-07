//
//  TrackingDate+CoreDataProperties.swift
//  26Tracking
//
//  Created by Taras on 11/7/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import Foundation
import CoreData


extension TrackingDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackingDate> {
        return NSFetchRequest<TrackingDate>(entityName: "TrackingDate");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var toTrackingTime: NSSet?

}

// MARK: Generated accessors for toTrackingTime
extension TrackingDate {

    @objc(addToTrackingTimeObject:)
    @NSManaged public func addToToTrackingTime(_ value: TrackingTime)

    @objc(removeToTrackingTimeObject:)
    @NSManaged public func removeFromToTrackingTime(_ value: TrackingTime)

    @objc(addToTrackingTime:)
    @NSManaged public func addToToTrackingTime(_ values: NSSet)

    @objc(removeToTrackingTime:)
    @NSManaged public func removeFromToTrackingTime(_ values: NSSet)

}
