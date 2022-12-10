//
//  AddNewTransactionModalViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 08/12/22.
//

import Foundation

extension TransactionModalViewController: AddTransactionDelegate {
    func goToBudgetPlanner() {
        let targetViewController = SetupPageViewController()
        targetViewController.delegate = self
        targetViewController.modalPresentationStyle = .fullScreen
        present(targetViewController, animated: true)
    }
    
    func openCategoryBudgetSelector() {
        let targetViewController = CategoryBudgetSelectionViewController()
        targetViewController.selectedDelegate = self
        if transactionType == TransactionType.expense.rawValue {
            targetViewController.forBudget = TransactionType.expense
        } else {
            targetViewController.forBudget = TransactionType.goal
        }
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func openTypeSelector() {
        let targetViewController = TypePickerViewController()
        targetViewController.delegate = self
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func shouldEnableSaveButton() {
        let amountString = (addTransactionModalView.transactionAmount.textField.text ?? "0.0").replacingOccurrences(of: ".", with: "")
        let category = addTransactionModalView.transactionBudgetCategory.textField.text ?? ""
        
        var valid = true
        valid = valid ? !(addTransactionModalView.transactionName.textField.text ?? "").isEmpty : valid
        valid = valid ? (Double(amountString) ?? 0.0) > 0 : valid
        valid = valid ? !(addTransactionModalView.transactionDate.textField.textField.text ?? "").isEmpty : valid
        
        if transactionType == TransactionType.goal.rawValue {
            valid = valid ? category == "Lainnya" ? false : !category.isEmpty : valid
        }
        else if transactionType == TransactionType.income.rawValue {
            valid = valid ? true : valid
        }
        else if transactionType == TransactionType.expense.rawValue {
            valid = valid ? !category.isEmpty : valid
        }
        else {
            valid = false
        }
        
        navigationItem.rightBarButtonItem?.isEnabled = valid
    }
}

extension TransactionModalViewController: DismissViewDelegate {
    var viewControllerTitle: String { title ?? "Tambah Transaksi" }
    
    func viewDismissed() {
        viewDidLoad()
    }
}

extension TransactionModalViewController: FilterDelegate {
    func selected(selectedItem: String) {
        self.transactionType = selectedItem
        addTransactionModalView.transactionType.textField.text = selectedItem
        if transactionType == TransactionType.income.rawValue {
            let incomeCategory = DatabaseHelper.shared.getCategory(name: "Income")
            addTransactionModalView.iconTextField.text = incomeCategory?.icon
        }
        configureView()
        shouldEnableSaveButton()
    }
    
    func openPicker(type: String) {
        print("Nothing to do here")
    }
    
    func filterTransaction() {
        print("Nothing to do here")
    }
}

extension TransactionModalViewController: SelectCategoryBudgetDelegate {
    func selectedItem(budget: Budget?) {
        self.budget = budget
        self.addTransactionModalView.transactionBudgetCategory.textField.text = budget?.category?.name ?? "Lainnya"
        addTransactionModalView.iconTextField.text = budget?.category?.icon
        shouldEnableSaveButton()
    }
}
