//
//  TransactionFilterViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import Foundation

extension TransactionFilterViewController: FilterDelegate {
    func selected(selectedItem: String) {
        transactionType = selectedItem
        filter.transactionTypeSelector.textField.text = selectedItem
    }
    
    func openPicker(type: String) {        
        switch type {
            case TypePickerViewController.identifier:
                print("Open picker for type")
                let targetViewController = TypePickerViewController()
                targetViewController.delegate = self
                navigationController?.pushViewController(targetViewController, animated: true)
                
            case "BudgetCategory":
                print("Open picker for category budget")
                let targetViewController = CategoryBudgetSelectionViewController()
                targetViewController.selectedDelegate = self
                navigationController?.pushViewController(targetViewController, animated: true)
                
            default:
                print("Oops something went wrong in \(#function)")
        }
    }
    
    func filterTransaction() {
        startDate = filter.startMonthPicker.date ?? Date(timeIntervalSince1970: 0)
        endDate = filter.endMonthPicker.date ?? Date()
        
        delegate?.filterTransaction(startMonth: startDate, endMonth: endDate, type: self.transactionType, budgetCategory: self.budgetCategory ?? nil)
        dismissView()
    }
}

extension TransactionFilterViewController: SelectBudgetCategoryViewControllerDelegate {
    func selected(category: Category) {
        budgetCategory = category
        filter.categoryBudgetSelector.textField.text = category.name
    }
}

extension TransactionFilterViewController: SelectCategoryBudgetDelegate {
    func selectedItem(budget: Budget?) {
        filter.categoryBudgetSelector.textField.text = budget?.category?.name ?? "Lainnya"
        self.budgetCategory = budget?.category
    }
    
    
}
