//
//  AddBudgetViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 18/11/22.
//

import UIKit


protocol BudgetDelegate: AnyObject {
    func addBudget()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupData() {
        goalBudgets = DatabaseHelper().getBudgets(on: Date(), type: "Goal")
        needBudgets = DatabaseHelper().getBudgets(on: Date(), type: "Need")
        wantBudgets = DatabaseHelper().getBudgets(on: Date(), type: "Want")

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

        shouldDisableAddButton()
    }
    
    func shouldDisableAddButton(enable: Bool? = false) {
        print(#function)
        
        if let enable = enable {
            isEnabled = enable
        } else {
            isEnabled = !goalBudgets.isEmpty
        }
        
        addBudgetView.needStack.addButton.setButtonByStatus(isEnabled: isEnabled, backColor: isEnabled ? .secondary1! : .black4!, textColor: isEnabled ? .secondary8! : .black7!)
        addBudgetView.wantStack.addButton.setButtonByStatus(isEnabled: isEnabled, backColor: isEnabled ? .secondary1! : .black4!, textColor: isEnabled ? .secondary8! : .black7!)
        
    }
}
