//
//  Annotation.swift
//  Pilot this
//
//  Created by Gustavo Villar on 2/27/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import Foundation
import CoreData

class Annotation: NSManagedObject {

    @NSManaged var level: NSNumber
    @NSManaged var comment: String?
    @NSManaged var created_at: NSDate
    @NSManaged var product: Product
    
    class func levelName(level: NSNumber) -> String {
        switch level.integerValue {
        case 1:
            return "I barely need it"
        case 2:
            return "I kinda need it"
        case 3:
            return "I really need it"
        case 4:
            return "I totally need it"
        case 5:
            return "I'm dying for this"
        default:
            println("Unsuported level found on class Annotation: \(level)")
            return ""
        }
    }
    
    func levelName() -> String {
        return Annotation.levelName(level)
    }
    
    // Set default values on insert
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        created_at = NSDate()
    }

}
