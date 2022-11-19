//
//  AddBudgetViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 19/11/22.
//

import Foundation

extension AddBudgetViewController: BudgetDelegate {
    func addBudget() {
        shouldDisableAddButton(enable: true)
    }
    
    func showTip() {
        self.showExplanation()
    }
}
