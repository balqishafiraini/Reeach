//
//  DatabaseHelper.swift
//  Reeach
//
//  Created by William Chrisandy on 13/10/22.
//

import UIKit
import CoreData

class DatabaseHelper {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
    }
    
    func insert<T: Identifiable>(_ object: T) -> T where T: NSManagedObject {
        if var object = object as? AutoIncrementInt64Id {
            let keyLastId = type(of: object).keyLastId
            object.id = Int64(UserDefaults.standard.integer(forKey: keyLastId) + 1)
            UserDefaults.standard.set(object.id, forKey: keyLastId)
        }
        
        context.refresh(object, mergeChanges: true)
        context.insert(object)
        saveContext()
        
        return object
    }
    
    func delete<T: Identifiable>(_ object: T) -> T where T: NSManagedObject {
        context.delete(object)
        saveContext()
        return object
    }
    
    func saveContext() {
        do {
            try context.save()
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
        }
    }
    
    func rollbackContext() {
        context.rollback()
    }
}
