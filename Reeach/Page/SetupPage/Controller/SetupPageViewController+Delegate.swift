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
    
    func addBudget(type: String, budget: Budget) {
        print(#function)
        switch type {
        case "Goal":
//            goalBudgets.append(budget)
            let _ = contentView.content as! AddBudget
//            content.goalStack.setupStatusLabel(budgets: goalBudgets)
            
        case "Need":
            needBudgets.append(budget)
        case "Want":
            wantBudgets.append(budget)
        default:
            print("Wtf do u want?")
        }
    }
    
    func saveIncome(income: String) {
        self.income = (income as NSString).floatValue
        shouldDisableButton(progressIndex: currentProgressIndex)
    }
    
}

extension SetupPageViewController: BudgetDelegate {
    func addBudget() {
        print(#function)
    }
}

