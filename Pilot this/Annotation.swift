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
    @NSManaged var comment: String
    @NSManaged var created_at: NSDate
    @NSManaged var product: Product
    
    class func levelName(level: NSNumber) -> String {
        switch level.integerValue {
        case 0:
            return "I barely need it"
        case 1:
            return "I kinda need it"
        default:
            println("Unsuported level found on class Annotation")
            return ""
        }
    }
    
    func levelName() -> String {
        return Annotation.levelName(level)
    }
    

}
