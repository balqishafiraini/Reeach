//
//  AddBudgetViewController+Delegate.swift
//  Reeach
//
<<<<<<< HEAD
//  Created by William Chrisandy on 19/11/22.
=======
//  Created by James Christian Wira on 19/11/22.
>>>>>>> 91b79da (Feat: Add temporary function to disable addBudget button)
//

import Foundation

<<<<<<< HEAD
extension AddBudgetViewController: DismissViewDelegate {
    func viewDismissed() {
        viewWillAppear(false)
=======
extension AddBudgetViewController: BudgetDelegate {
    func addBudget() {
        shouldDisableAddButton(enable: true)
>>>>>>> 91b79da (Feat: Add temporary function to disable addBudget button)
    }
    
    func showTip() {
        self.showExplanation()
    }
}
