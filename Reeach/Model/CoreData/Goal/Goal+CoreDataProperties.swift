//
//  Goal+CoreDataProperties.swift
//  Reeach
//
//  Created by William Chrisandy on 15/10/22.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isAchievable: Bool
    @NSManaged public var isActive: Bool
    @NSManaged public var targetAmount: NSNumber?
    @NSManaged public var timeTerm: String?
    @NSManaged public var updatedAt: Date?

}
