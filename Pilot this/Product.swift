//
//  Product.swift
//  Pilot this
//
//  Created by Gustavo Villar on 2/27/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import Foundation
import CoreData

class Product: NSManagedObject {

    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var created_at: NSDate?
    @NSManaged var picture_data: NSData?
    @NSManaged var annotations: NSSet
    
    var picture: UIImage? {
        
        get {
            if let unwrapped_data = picture_data {
                return UIImage(data: unwrapped_data)
            }
            return nil
        }
        
        set(new_picture) {
            picture_data = UIImagePNGRepresentation(new_picture)
        }
    }
    
    var days: Int? {
        if let unwrapped_created_at = created_at {
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        
        // Replace the hour (time) of both dates with 00:00
//        let date1 = calendar.startOfDayForDate(created_at!)
//        let date2 = calendar.startOfDayForDate(NSDate())
        
        let unit = NSCalendarUnit.DayCalendarUnit
        let components = calendar.components(unit, fromDate: unwrapped_created_at, toDate: NSDate(), options: nil)
        
        return components.day  // This will return the number of day(s) between dates
        }
        return nil
    }
    
    override func validateForInsert(error: NSErrorPointer) -> Bool {
        return super.validateForInsert(error)
    }

}
