//
//  TransactionCategoryDetailViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 09/12/22.
//

import UIKit

extension TransactionCategoryDetailViewController: TransactionDelegate {
    func openSheet() {
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let vc = TransactionFilterViewController()
        vc.delegate = self
        vc.budgetCategory = category
        vc.modalPresentationStyle = .pageSheet
        
        navigationController.pushViewController(vc, animated: true)
        
        self.present(navigationController, animated: true)
    }
    
    func search(searchText: String) {
        self.searchText = searchText
        
        if searchText.isEmpty {
            configureData()
        } else {
            configureSearchData()
        }
    }
    
    func dismiss() {
        dismissDelegate?.viewDismissed()
        dismiss(animated: true)
    }
    
    func filterTransaction(startMonth: Date?, endMonth: Date?, type: String?, budgetCategory: Category?) {
        configureFilteredData(startMonth: startMonth, endMonth: endMonth, type: type, categoryBudget: budgetCategory)
    }
    
    func openTransactionModal(transaction: Transaction? = nil) {
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let vc = TransactionModalViewController()
        if let transaction = transaction {
            vc.budget = transaction.budget
            vc.transaction = transaction
            vc.mode = .edit
        } else {
            vc.budget = self.budget
            vc.mode = .add
            vc.pressableSelector = false
        }
        vc.dismissDelegate = self
        vc.modalPresentationStyle = .pageSheet
        
        navigationController.pushViewController(vc, animated: true)
        
        self.present(navigationController, animated: true)
    }
}

extension TransactionCategoryDetailViewController: DismissViewDelegate {
    func viewDismissed() {
        self.configureData()
    }
}
