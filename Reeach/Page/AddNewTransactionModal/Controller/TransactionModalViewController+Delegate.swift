//
//  AddNewTransactionModalViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 08/12/22.
//

import Foundation

extension TransactionModalViewController: AddTransactionDelegate {
    func openCategoryBudgetSelector() {
        let targetViewController = CategoryBudgetSelectionViewController()
        targetViewController.selectedDelegate = self
        if transactionType == TransactionType.expense.rawValue {
            targetViewController.forBudget = TransactionType.expense
        } else {
            targetViewController.forBudget = TransactionType.goal
        }
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func openTypeSelector() {
        let targetViewController = TypePickerViewController()
        targetViewController.delegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
}

extension TransactionModalViewController: FilterDelegate {
    func selected(selectedItem: String) {
        self.transactionType = selectedItem
        addTransactionModalView.transactionType.textField.text = selectedItem
        
        configureView()
    }
    
    func openPicker(type: String) {
        print("Nothing to do here")
    }
    
    func filterTransaction() {
        print("Nothing to do here")
    }
}

extension TransactionModalViewController: SelectCategoryBudgetDelegate {
    func selectedItem(budget: Budget?) {
        self.budget = budget
        self.addTransactionModalView.transactionBudgetCategory.textField.text = budget?.category?.name ?? "Lainnya"
    }
}
