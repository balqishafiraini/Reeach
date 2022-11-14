//
//  BudgetWantsModalViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class BudgetWantsModalViewController: UIViewController {
    
    let budgetWantssModalView = BudgetWantsModalView()


    override func viewDidLoad() {
        super.viewDidLoad()
        budgetWantssModalView.configureStackView()
        view = budgetWantssModalView
    }

}
