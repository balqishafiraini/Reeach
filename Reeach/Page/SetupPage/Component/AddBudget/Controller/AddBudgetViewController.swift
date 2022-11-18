//
//  AddBudgetViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 18/11/22.
//

import UIKit

class AddBudgetViewController: UIViewController {

    let addBudgetView = AddBudget()
    
    weak var delegate: SetupPageViewController?
    
    var goalBudgets: [Budget] = []
    var needBudgets: [Budget] = []
    var wantBudgets: [Budget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view = addBudgetView
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        goalBudgets = DatabaseHelper().getBudgets(on: Date(), type: "Goal")
        needBudgets = DatabaseHelper().getBudgets(on: Date(), type: "Need")
        wantBudgets = DatabaseHelper().getBudgets(on: Date(), type: "Want")
        
        addBudgetView.goalBudgets = self.goalBudgets
        addBudgetView.needBudgets = self.needBudgets
        addBudgetView.wantBudgets = self.wantBudgets
        
        addBudgetView.delegate = delegate
        
        addBudgetView.goalStack.removeFromSuperview()
        addBudgetView.needStack.removeFromSuperview()
        addBudgetView.wantStack.removeFromSuperview()
        
        delegate?.goalBudgets = goalBudgets
        delegate?.needBudgets = needBudgets
        delegate?.wantBudgets = wantBudgets
        delegate?.setDisableButton()
        
        addBudgetView.setupView()
    }

}
