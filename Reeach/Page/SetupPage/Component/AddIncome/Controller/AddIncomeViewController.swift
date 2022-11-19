//
//  AddIncomeViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 19/11/22.
//

import UIKit

class AddIncomeViewController: UIViewController {

    weak var delegate: SetupPageViewController?
    
    var addIncomeView = AddIncome()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view = addIncomeView
        view.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let incomeCategory = DatabaseHelper().getCategory(name: "Income")
        let incomeBudget = DatabaseHelper().getBudget(on: Date(), of: incomeCategory!)
        let income = incomeBudget?.monthlyAllocation ?? 0.0
        
        addIncomeView.income = income
        addIncomeView.delegate = delegate
        delegate?.income = income
        delegate?.shouldDisableButton()
        addIncomeView.setupView()
    }

}


