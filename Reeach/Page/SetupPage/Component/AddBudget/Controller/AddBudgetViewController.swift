//
//  AddBudgetViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 18/11/22.
//

import UIKit


protocol BudgetDelegate: AnyObject {
    func addBudget()
    func showTip()
}

class AddBudgetViewController: UIViewController {

    let addBudgetView = AddBudget()
    
    weak var delegate: SetupPageViewController?
    
    var goalBudgets: [Budget] = []
    var needBudgets: [Budget] = []
    var wantBudgets: [Budget] = []
    var isEnabled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view = addBudgetView
        
        let databaseHelper = DatabaseHelper.shared
        
        goalBudgets = databaseHelper.getBudgets(on: Date(), type: "Goal")
        needBudgets = databaseHelper.getBudgets(on: Date(), type: "Need")
        wantBudgets = databaseHelper.getBudgets(on: Date(), type: "Want")
        
        if goalBudgets.isEmpty && needBudgets.isEmpty && wantBudgets.isEmpty {
            print("Budget is empty, using previous month data")
            let oldGoalBudgets = databaseHelper.getBudgets(on: DateFormatHelper.getStartDateOfPreviousMonth(of: Date()), type: "Goal")
            self.goalBudgets = databaseHelper.copyBudgets(oldGoalBudgets, to: Date())
            
            let oldNeedBudget = databaseHelper.getBudgets(on: DateFormatHelper.getStartDateOfPreviousMonth(of: Date()), type: "Need")
            self.needBudgets = databaseHelper.copyBudgets(oldNeedBudget, to: Date())
            
            let oldWantBudget = databaseHelper.getBudgets(on: DateFormatHelper.getStartDateOfPreviousMonth(of: Date()), type: "Want")
            self.wantBudgets = databaseHelper.copyBudgets(oldWantBudget, to: Date())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupData() {
        let databaseHelper = DatabaseHelper.shared
        goalBudgets = databaseHelper.getBudgets(on: Date(), type: "Goal")
        needBudgets = databaseHelper.getBudgets(on: Date(), type: "Need")
        wantBudgets = databaseHelper.getBudgets(on: Date(), type: "Want")
        
        addBudgetView.goalBudgets = self.goalBudgets
        addBudgetView.needBudgets = self.needBudgets
        addBudgetView.wantBudgets = self.wantBudgets

        addBudgetView.delegate = delegate
        addBudgetView.budgetDelegate = self

        addBudgetView.goalStack.removeFromSuperview()
        addBudgetView.needStack.removeFromSuperview()
        addBudgetView.wantStack.removeFromSuperview()

        delegate?.goalBudgets = goalBudgets
        delegate?.needBudgets = needBudgets
        delegate?.wantBudgets = wantBudgets
        delegate?.setDisableButton()

        addBudgetView.setupView()
        delegate?.shouldDisableButton()
    }
    
    func showExplanation(){
        let modalViewController = BudgetingTechniqueExplanationViewController()
        modalViewController.modalPresentationStyle = .pageSheet
        modalViewController.modalTransitionStyle = .coverVertical

        delegate?.present(modalViewController, animated: true)
    }
}
