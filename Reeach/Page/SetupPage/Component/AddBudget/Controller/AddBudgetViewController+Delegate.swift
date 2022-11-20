//
//  AddBudgetViewController+Delegate.swift
//  Reeach
//

import Foundation

extension AddBudgetViewController: DismissViewDelegate {
    func viewDismissed() {
        viewWillAppear(false)
    }
}

extension AddBudgetViewController: BudgetDelegate {
    func addBudget() {
        shouldDisableAddButton(enable: true)
    }
    
    func showTip() {
        self.showExplanation()
    }
}
