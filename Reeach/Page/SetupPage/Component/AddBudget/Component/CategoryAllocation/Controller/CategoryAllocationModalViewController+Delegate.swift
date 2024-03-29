//
//  CategoryAllocationModalViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension CategoryAllocationModalViewController: NavigationBarDelegate {
    func cancel() {
        if mode == .edit {
            budget?.category = initialCategory
            budget?.monthlyAllocation = initialMonthlyAllocation
            DatabaseHelper.shared.saveContext()
        }
        dismissView()
    }
}

extension CategoryAllocationModalViewController: SelectBudgetCategoryViewControllerDelegate {
    func selected(category: Category) {
        categoryAllocationModalView.iconWithoutEdit.iconLabel.font = .systemFont(ofSize: 58, weight: .bold)
        categoryAllocationModalView.iconWithoutEdit.iconLabel.text = category.icon
        categoryAllocationModalView.category.textField.text = category.name
        categoryAllocationModalView.textFieldsIsNotEmpty(categoryAllocationModalView.category.textField)
        currentCategory = category
    }
}

extension CategoryAllocationModalViewController: CategoryAllocationModalViewDelegate {
    func goToSelectCategory() {
        let targetViewController = SelectBudgetCategoryViewController()
        targetViewController.delegate = self
        targetViewController.type = type == .needs ? "Need" : "Want"
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func save(monthlyAllocation: Double) {
        let databaseHelper = DatabaseHelper.shared
        if let currentCategory, mode == .add {
            let _ = databaseHelper.createBudget(monthlyAllocation: currentMonthlyAllocation, period: Date(), category: currentCategory)
            dismissView()
        }
        else if mode == .edit {
            budget?.category = currentCategory
            budget?.monthlyAllocation = currentMonthlyAllocation
            databaseHelper.saveContext()
            dismissView()
        }
    }
    
    func delete() {
        if let budget {
            let _ = DatabaseHelper.shared.delete(budget)
        }
        dismissView()
    }
    
    func updateRemainingLabel() {
        let monthlyAllocation: Double = {
            guard let monthlyAllocationString = categoryAllocationModalView.monthlyAllocation.textField.text?.replacingOccurrences(of: ".", with: ""), monthlyAllocationString != ""
            else { return 0 }
            return Double(monthlyAllocationString) ?? 0
        }()
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black13 as Any,
            .font: UIFont.caption1Bold as Any
        ]

        let mediumAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black13 as Any,
            .font: UIFont.caption1Medium as Any
        ]
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Sisa anggaran: ", attributes: mediumAttributes)
        attributedString.append(NSAttributedString(string: CurrencyHelper.getCurrency(from: maximumAllocation - monthlyAllocation), attributes: boldAttributes))

        categoryAllocationModalView.remainingLabel.attributedText = attributedString
    }
    
    func validate(monthlyAllocation: Double) {
        if monthlyAllocation <= 0 || monthlyAllocation > maximumAllocation {
            currentMonthlyAllocation = 0
            categoryAllocationModalView.saveButton.backgroundColor = .black4
            categoryAllocationModalView.saveButton.setTitleColor(UIColor.black7, for: .normal)
            categoryAllocationModalView.saveButton.isEnabled = false
        }
        else if currentCategory != nil {
            currentMonthlyAllocation = monthlyAllocation
            categoryAllocationModalView.saveButton.backgroundColor = .tangerineYellow
            categoryAllocationModalView.saveButton.setTitleColor(UIColor.black13, for: .normal)
            categoryAllocationModalView.saveButton.isEnabled = true
        }
        
        categoryAllocationModalView.monthlyAllocation.textField.text = CurrencyHelper.getFormattedNumber(from: currentMonthlyAllocation)
        updateRemainingLabel()
        
        return
    }
}
