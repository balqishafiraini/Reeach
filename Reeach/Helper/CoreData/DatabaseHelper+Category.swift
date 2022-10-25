//
//  DatabaseHelper+Category.swift
//  Reeach
//
//  Created by William Chrisandy on 25/10/22.
//

import CoreData

extension DatabaseHelper {
    func getCategories() -> [Category] {
        do {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getCategory(name: String) -> Category? {
        do {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest(name: name)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return nil
        }
    }
    
    func getCategories(type: String) -> [Category] {
        do {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest(type: type)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func createCategory(name: String, type: String, icon: String) -> Category {
        if let category = getCategory(name: name) {
            return category
        }
        else {
            let category = Category(context: context)
            category.name = name
            category.type = type
            category.icon = icon
            
            return insert(category)
        }
    }
}
