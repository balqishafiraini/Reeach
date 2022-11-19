//
//  GoalModalViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension GoalModalViewController: NavigationBarDelegate {
    func cancel() {
        let databaseHelper = DatabaseHelper.shared
        if let goal, mode == .add {
            let _ = databaseHelper.delete(goal)
        }
        else if mode == .edit {
            databaseHelper.rollbackContext()
        }
        dismissView()
    }
}

extension GoalModalViewController: TermPickerViewControllerDelegate {
    func selected(timeTerm: String) {
        goalModalView.goalType.textField.text = "\(timeTerm)-term"
        goalModalView.textFieldsIsNotEmpty(goalModalView.goalType.textField)
    }
}

extension GoalModalViewController: GoalRecommendationViewControllerDelegate {
    func selected(recommendation: Goal.Recommendation) {
        goalModalView.iconView.iconTextField.text = recommendation.icon
        goalModalView.goalName.textField.text = recommendation.name
        goalModalView.goalType.textField.text = "\(recommendation.term)-term"
        goalModalView.textFieldsIsNotEmpty(goalModalView.goalType.textField)
    }
}

extension GoalModalViewController: GoalModalViewDelegate {
    func updateInflationButton() {
        guard let goal
        else { return }
        
        let targetAmount: Double = {
            guard let targetAmountString = goalModalView.total.textField.text, targetAmountString != ""
            else { return 0 }
            return Double(targetAmountString) ?? 0
        }()
        goal.targetAmount = targetAmount
        
        let dueDate: Date = {
            guard let dueDate = goalModalView.dueDate.date
            else { return goal.dueDate ?? Date() }
            return dueDate
        }()
        goal.dueDate = dueDate
        
        let blackAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black13 as Any,
            .font: UIFont.caption1Bold as Any
        ]
        
        let blueAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.secondary as Any,
            .font: UIFont.caption1Bold as Any
        ]
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "WATCH OUT! Nilai setelah inflasi: ", attributes: blueAttributes)
        attributedString.append(NSAttributedString(string: CurrencyHelper.getCurrency(from: goal.valueAfterInflation(from: Date())), attributes: blackAttributes))
        
        goalModalView.inflationButton.setAttributedTitle(attributedString, for: .normal)
        DatabaseHelper.shared.rollbackContext()
    }
    
    func goToGoalRecommendation() {
        let targetViewController = GoalRecommendationViewController()
        targetViewController.delegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func goToInflationDetail() {
        let targetViewController = InflationDetailViewController()
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func save(name: String, icon: String, dueDate: Date, targetAmount: Double, timeTerm: String, initialSaving: Double) {
        guard let goal
        else { return }
        
        let databaseHelper = DatabaseHelper.shared
        goal.icon = icon
        goal.name = name
        goal.dueDate = dueDate
        goal.targetAmount = targetAmount
        goal.timeTerm = timeTerm
        goal.updatedAt = Date()
        databaseHelper.saveContext()
        
        if mode == .add {
            let date = DateFormatHelper.getStartDateOfPreviousMonth(of: Date())
            let budget = databaseHelper.createBudget(monthlyAllocation: initialSaving, period: date, category: goal)
            let _ = databaseHelper.createTransaction(name: "Initial Saving", date: date, budget: budget, amount: initialSaving, notes: "")
        }
        else if mode == .edit {
            let previousInitialSaving = goal.initialSaving(before: Date())
            let difference = initialSaving - previousInitialSaving
            if difference != 0 {
                let date = goal.updatedAt ?? Date()
                let budget = databaseHelper.createBudget(monthlyAllocation: initialSaving, period: date, category: goal)
                let _ = databaseHelper.createTransaction(
                    name: "Edit Initial Saving",
                    date: date,
                    budget: budget,
                    amount: difference,
                    notes: "Previous Initial Saving: \(previousInitialSaving).\nCNew Initial Saving: \(initialSaving)"
                )
            }
        }
        dismissView()
    }
    
    func goToTermPicker() {
        let targetViewController = TermPickerViewController()
        targetViewController.delegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
}
