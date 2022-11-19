//
//  AddCategoryViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension AddCategoryViewController: NavigationBarDelegate {
    func cancel() {
        if let category {
            let _ = DatabaseHelper.shared.delete(category)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension AddCategoryViewController: AddCategoryViewDelegate {
    func save(icon: String, name: String) {
        print(#function)
        category?.icon = icon
        category?.name = name
        DatabaseHelper.shared.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func edit() {
        print(#function)
    }
}

