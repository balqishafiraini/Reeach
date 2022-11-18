//
//  SetupPageViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 15/11/22.
//

import Foundation

extension SetupPageViewController: SetupDelegate {
    
    func updateProgress() {
        currentProgressIndex += 1.0
        currentProgress = currentProgressIndex / totalProgress
        
        if currentProgressIndex > totalProgress {
            currentProgress = 0.0
            currentProgressIndex = 0.0
        }
        
        updateView()
    }
    
    func previousProgress() {
        currentProgressIndex -= 1.0
        currentProgress = currentProgressIndex / totalProgress
        updateView()
    }
    
    func openGoalSheet() {
        let goalVC = GoalModalViewController()
        goalVC.modalPresentationStyle = .popover
        goalVC.modalTransitionStyle = .coverVertical
        self.show(goalVC, sender: self)
    }
    
    func saveIncome(income: String) {
        self.income = (income as NSString).doubleValue
        let income = DatabaseHelper().getCategory(name: "Income")
        if let incomeBudget = DatabaseHelper().getBudget(on: Date(), of: income!) {
            incomeBudget.monthlyAllocation = self.income
            
            DatabaseHelper().saveContext()
        } else {
            let _ = DatabaseHelper().createBudget(monthlyAllocation: self.income, period: Date(), category: income!)
        }
        shouldDisableButton(progressIndex: currentProgressIndex)
    }
    
    func setDisableButton(progressIndex: Float? = nil) {
        shouldDisableButton(progressIndex: progressIndex)
    }
    
}

extension SetupPageViewController: BudgetDelegate {
    func addBudget() {
        print(#function)
    }
}

