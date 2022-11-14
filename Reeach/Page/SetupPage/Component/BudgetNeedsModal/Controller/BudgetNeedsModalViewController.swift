//
//  BudgetNeedsModalViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class BudgetNeedsModalViewController: UIViewController {
    
    let budgetNeedsModalView = BudgetNeedsModalView()

    override func viewDidLoad() {
        super.viewDidLoad()

        budgetNeedsModalView.configureStackView()
        view = budgetNeedsModalView
    
    }
}
