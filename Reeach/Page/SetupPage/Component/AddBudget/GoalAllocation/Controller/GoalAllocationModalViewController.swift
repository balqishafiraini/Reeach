//
//  GoalAllocationModalViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class GoalAllocationModalViewController: UIViewController {
    
    enum EditMode {
        case add
        case edit
    }
    
    var budget: Budget?
    var goal: Goal?
    var maximumAllocation: Double = 0
    var unallocatedIncome: Double = 0
    var mode: EditMode = .edit
    weak var delegate: DismissViewDelegate?
    let goalAllocationModalView = GoalAllocationModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Alokasi Goal"
        
        if let goal, mode == .add {
            budget = DatabaseHelper.shared.createBudget(monthlyAllocation: 0, period: Date(), category: goal)
        }
        if let budget, mode == .edit {
            guard let goal = budget.category as? Goal
            else {
                dismissView()
                return
            }
            self.goal = goal
            goalAllocationModalView.monthlyAllocationTextField.textField.text = CurrencyHelper.getFormattedNumber(from: budget.monthlyAllocation)
        }
        
        guard let goal
        else {
            dismissView()
            return
        }
        
        goalAllocationModalView.iconTextField.text = goal.icon
        goalAllocationModalView.goalNameTextField.textField.text = goal.name
        goalAllocationModalView.dueDateDatePicker.date = goal.dueDate
        goalAllocationModalView.dueDateDatePicker.textField.textField.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
        goalAllocationModalView.targetAmountTextField.textField.text = CurrencyHelper.getFormattedNumber(from: goal.targetAmount)
        
        calculateMaxAllocation()
        goalAllocationModalView.textFieldsIsNotEmpty(goalAllocationModalView.monthlyAllocationTextField.textField)
    }
    
    override func loadView() {
        super.loadView()
        
        goalAllocationModalView.configureStackView(viewContoller: self)
        view = goalAllocationModalView
        
        if mode == .add {
            goalAllocationModalView.deleteButton.isHidden = true
        }
        else if mode == .edit {
            goalAllocationModalView.deleteButton.isHidden = false
        }
    }
    
    func dismissView(){
        delegate?.viewDismissed()
        self.dismiss(animated: true, completion: nil)
    }
    
    func calculateMaxAllocation() {
        let databaseHelper = DatabaseHelper.shared
        
        guard let incomeCategory = databaseHelper.getCategory(name: "Income")
        else { return }
        
        guard let incomeBudget = databaseHelper.getBudget(on: Date(), of: incomeCategory)
        else { return }
        
        unallocatedIncome = incomeBudget.monthlyAllocation
        maximumAllocation = incomeBudget.monthlyAllocation * 0.2
        
        let goals = databaseHelper.getBudgets(on: Date(), type: "Goal")
        for goal in goals {
            unallocatedIncome -= goal.monthlyAllocation
            maximumAllocation -= goal.monthlyAllocation
        }
        
        let needs = databaseHelper.getBudgets(on: Date(), type: "Need")
        for need in needs {
            unallocatedIncome -= need.monthlyAllocation
        }
        
        let wants = databaseHelper.getBudgets(on: Date(), type: "Want")
        for want in wants {
            unallocatedIncome -= want.monthlyAllocation
        }
        
        guard let budget
        else { return }
        
        unallocatedIncome += budget.monthlyAllocation
        maximumAllocation += budget.monthlyAllocation
    }
}
