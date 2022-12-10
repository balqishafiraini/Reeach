//
//  TransactionFilterViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TransactionFilterViewController: UIViewController {

    var filter = TransactionFilterView()
    weak var delegate: TransactionDelegate?
    
    var startDate: Date?
    var endDate: Date?
    var transactionType: String?
    var budgetCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = filter
        setNavigationBar()
        
        filter.controller = self
        filter.delegate = self
        filter.setupView()
        shouldHideCategoryBudget()
    }
    
    func setNavigationBar() {
        self.title = "Filter Transaksi"
        let doneItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        doneItem.setTitleTextAttributes(attributes, for: .normal)
        
        navigationItem.leftBarButtonItem = doneItem
        navigationController?.navigationBar.backgroundColor = .ghostWhite
    }
    
    func shouldHideCategoryBudget() {
        switch transactionType {
            case TransactionType.expense.rawValue:
                filter.categoryBudgetSelector.isHidden = false
                
            case TransactionType.goal.rawValue:
                filter.categoryBudgetSelector.isHidden = false
                
            default:
                filter.categoryBudgetSelector.isHidden = true
        }
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
