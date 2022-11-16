//
//  SelectBudgetCategoryDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

protocol SelectBudgetCategoryViewDelegate: AnyObject {
    func addCategory()
}

protocol SelectBudgetCategoryViewControllerDelegate: AnyObject {
    func selected(category: Category)
}
