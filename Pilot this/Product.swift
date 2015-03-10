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
            
            let unit = NSCalendarUnit.DayCalendarUnit
            let components = calendar.components(unit, fromDate: unwrapped_created_at, toDate: NSDate(), options: nil)
            
            return components.day  // This will return the number of day(s) between dates
        }
        return nil
    }
    
    func daysAsString() -> String {
        if let unwrapped_days = days {
            switch unwrapped_days {
            case 1: return "1 day" // Singular
            default: return "\(unwrapped_days) days" // Plural: e.g. 0 days, 15 days
            }
        }
        return "Unknown" // If days is nil
    }
    
    // Set default values on insert
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        created_at = NSDate()
    }


}
