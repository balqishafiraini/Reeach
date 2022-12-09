//
//  TransactionCategoryDetailViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 09/12/22.
//

import UIKit

extension TransactionCategoryDetailViewController: TransactionDelegate {
    func openSheet() {
        openFilterSheet()
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
        
        let vc = AddNewTransactionModalViewController()
        if let transaction = transaction {
            vc.budget = transaction.budget
            vc.transaction = transaction
            vc.mode = .edit
        } else {
            vc.budget = self.budget
            vc.mode = .add
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
