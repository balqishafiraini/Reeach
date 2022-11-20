//
//  GoalAllocationViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class CategoryAllocationModalViewController: UIViewController {
    
    enum CategoryType {
        case needs
        case wants
    }
    
    enum EditMode {
        case add
        case edit
    }
    
    var type: CategoryType = .needs
    var mode: EditMode = .add
    var budget: Budget?
    var initialCategory: Category?
    var currentCategory: Category?
    var initialMonthlyAllocation: Double = 0
    var currentMonthlyAllocation: Double = 0
    var maximumAllocation: Double = 0
    weak var delegate: DismissViewDelegate?
    let categoryAllocationModalView = CategoryAllocationModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = type == .needs ? "Kebutuhan Pokok" : "Kebutuhan Nonpokok"
        
        if let budget, mode == .edit {
            initialCategory = budget.category
            currentCategory = budget.category
            initialMonthlyAllocation = budget.monthlyAllocation
            currentMonthlyAllocation = budget.monthlyAllocation
            type = budget.category?.type == "Need" ? .needs : .wants
            
            categoryAllocationModalView.iconWithoutEdit.iconLabel.font = .systemFont(ofSize: 58, weight: .bold)
            categoryAllocationModalView.iconWithoutEdit.iconLabel.text = budget.category?.icon
            categoryAllocationModalView.category.textField.text = budget.category?.name
            categoryAllocationModalView.monthlyAllocation.textField.text = DoubleToStringHelper.getString(from: budget.monthlyAllocation)
        }
        
        calculateMaxAllocation()
        categoryAllocationModalView.textFieldsIsNotEmpty(categoryAllocationModalView.monthlyAllocation.textField)
    }
    
    func calculateMaxAllocation() {
        let databaseHelper = DatabaseHelper.shared
        
        guard let incomeCategory = databaseHelper.getCategory(name: "Income")
        else { return }
        
        guard let incomeBudget = databaseHelper.getBudget(on: Date(), of: incomeCategory)
        else { return }
        
        let goals = databaseHelper.getBudgets(on: Date(), type: "Goal")
        let needs = databaseHelper.getBudgets(on: Date(), type: "Need")
        let wants = databaseHelper.getBudgets(on: Date(), type: "Want")
        
        maximumAllocation = incomeBudget.monthlyAllocation
        for goal in goals {
            maximumAllocation -= goal.monthlyAllocation
        }
        
        let defaultLimit = incomeBudget.monthlyAllocation * 0.8
        
        if defaultLimit < maximumAllocation {
            maximumAllocation = defaultLimit
        }
        
        for need in needs {
            maximumAllocation -= need.monthlyAllocation
        }
        
        for want in wants {
            maximumAllocation -= want.monthlyAllocation
        }
        
        guard let budget
        else { return }
        
        maximumAllocation += budget.monthlyAllocation
    }
    
    override func loadView() {
        super.loadView()
        categoryAllocationModalView.configureStackView(viewController: self)
        view = categoryAllocationModalView
        
        title = type == .needs ? "Kebutuhan Pokok" : "Kebutuhan Non-Pokok"
        
        if mode == .add {
            categoryAllocationModalView.deleteButton.isHidden = true
        } else {
            categoryAllocationModalView.deleteButton.isHidden = false
        }
    }
    
    func dismissView(){
        delegate?.viewDismissed()
        self.dismiss(animated: true, completion: nil)
    }
}
