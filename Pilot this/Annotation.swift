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

}
