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
        
        var income: Double = 0.0
        let incomeCategory = DatabaseHelper().getCategory(name: "Income")
        let incomeBudget = DatabaseHelper().getBudget(on: Date(), of: incomeCategory!)
        
        if incomeBudget == nil {
            let prevIncomeBudget = DatabaseHelper.shared.getBudget(on: DateFormatHelper.getStartDateOfPreviousMonth(of: Date()), of: incomeCategory!)
            
            let _ = DatabaseHelper.shared.createBudget(monthlyAllocation: prevIncomeBudget?.monthlyAllocation ?? 0.0, period: Date(), category: incomeCategory!)
            
            income = prevIncomeBudget?.monthlyAllocation ?? 0.0
        } else {
            income = incomeBudget?.monthlyAllocation ?? 0.0
        }
        
        addIncomeView.income = income
        addIncomeView.delegate = delegate
        delegate?.income = income
        delegate?.shouldDisableButton()
        addIncomeView.setupView()
    }

}


