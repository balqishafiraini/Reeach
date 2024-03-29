//
//  MonthlyPlanningViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningViewController: UIViewController {

    var planningView = MonthlyPlanningView()
    
    var currentDate: Date = Date()
    
    var incomeBudgets: [Budget] = []
    var goalBudgets: [Budget] = []
    var needBudgets: [Budget] = []
    var wantBudgets: [Budget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        planningView = MonthlyPlanningView()
        
        self.view = planningView
        planningView.delegate = self
        planningView.setupDate(currentDate: currentDate)
        
        setupInitialState()
    }
    
    func setupInitialState(date: Date? = Date()) {
        let isInitialized = UserDefaults.standard.bool(forKey: DateFormatHelper.getShortMonthAndYearString(from: date!))
        
        let budgets = DatabaseHelper().getBudgets(on: date!)
        
        if budgets.isEmpty || !isInitialized {
            planningView.hasBudget = false
        } else {
            planningView.hasBudget = true
            
            incomeBudgets = DatabaseHelper().getBudgets(on: date!, type: "Income")
            goalBudgets = DatabaseHelper().getBudgets(on: date!, type: "Goal")
            needBudgets = DatabaseHelper().getBudgets(on: date!, type: "Need")
            wantBudgets = DatabaseHelper().getBudgets(on: date!, type: "Want")
            
            planningView.incomeBudgets = incomeBudgets
            planningView.goalBudgets = goalBudgets
            planningView.needBudgets = needBudgets
            planningView.wantBudgets = wantBudgets
        }
        
        planningView.setupView()
    }
}
