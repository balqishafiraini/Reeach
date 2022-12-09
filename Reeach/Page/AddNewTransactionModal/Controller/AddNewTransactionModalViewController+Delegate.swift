//
//  AddNewTransactionModalViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 08/12/22.
//

import Foundation

extension AddNewTransactionModalViewController: AddTransactionDelegate {
    func openCategoryBudgetSelector() {
        let targetViewController = CategoryBudgetSelectionViewController()
        targetViewController.selectedDelegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func openTypeSelector() {
        let targetViewController = TypePickerViewController()
        targetViewController.delegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
}

extension AddNewTransactionModalViewController: FilterDelegate {
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

extension AddNewTransactionModalViewController: SelectCategoryBudgetDelegate {
    func selectedItem(budget: Budget?) {
        self.budget = budget
        self.addTransactionModalView.transactionBudgetCategory.textField.text = budget?.category?.name ?? "Lainnya"
    }
}
