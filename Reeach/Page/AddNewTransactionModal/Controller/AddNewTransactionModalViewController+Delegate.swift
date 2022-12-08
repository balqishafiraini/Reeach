//
//  AddNewTransactionModalViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 08/12/22.
//

import Foundation

extension AddNewTransactionModalViewController: AddTransactionDelegate {
    func openCategoryBudgetSelector() {
        print(#function)
        let targetViewController = CategoryBudgetSelectionViewController()
        targetViewController.selectedDelegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
}

extension AddNewTransactionModalViewController: SelectCategoryBudgetDelegate {
    func selectedItem(budget: Budget) {
        print(#function)
        self.budget = budget
    }
}
