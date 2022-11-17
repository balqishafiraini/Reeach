//
//  GoalAllocationViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class CategoryAllocationModalViewController: UIViewController {
    
    enum CategoryType {
        case needs
        case wants
    }
    
    enum EditMode {
        case add
        case edit
    }
    
    var type: CategoryType = .needs
    var mode: EditMode = .add
    
    let categoryAllocationModalView = CategoryAllocationModalView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryAllocationModalView.category.textField.delegate = self
        categoryAllocationModalView.monthlyAllocation.textField.delegate = self
        
        
        categoryAllocationModalView.configureStackView()
        view = categoryAllocationModalView
        
        categoryAllocationModalView.monthlyAllocation.textField.keyboardType = .numberPad
        
        categoryAllocationModalView.layoutIfNeeded()
        self.setNavigationBar()
        self.hideKeyboardWhenTappedAround()
        setupAddTargetIsNotEmptyTextFields()
    }
    
    override func loadView() {
        super.loadView()
        title = type == .needs ? "Kebutuhan Pokok" : "Kebutuhan Non-Pokok"
        
        if mode == .add {
            categoryAllocationModalView.deleteButton.isHidden = true
        } else {
            categoryAllocationModalView.deleteButton.isHidden = false
        }
    }
    
    func setNavigationBar() {
        let doneItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        doneItem.setTitleTextAttributes(attributes, for: .normal)
        
        navigationItem.leftBarButtonItem = doneItem
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        categoryAllocationModalView.saveButton.isEnabled = false
        [
            //            categoryAllocationModalView.category.textField,
            categoryAllocationModalView.monthlyAllocation.textField].forEach({ $0.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged) })
        
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            //            let allocationCategory = categoryAllocationModalView.category.textField.text, !allocationCategory.isEmpty,
            let allocationAmount = categoryAllocationModalView.monthlyAllocation.textField.text, !allocationAmount.isEmpty
        else {
            categoryAllocationModalView.saveButton.isEnabled = false
            return
        }
        categoryAllocationModalView.saveButton.backgroundColor = .tangerineYellow
        categoryAllocationModalView.saveButton.setTitleColor(UIColor.black13, for: .normal)
        
        categoryAllocationModalView.saveButton.isEnabled = true
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension CategoryAllocationModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == categoryAllocationModalView.category.textField {
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == categoryAllocationModalView.category.textField {
            // TODO: GANTI TermPickerViewController KE CategoryViewController
            let goalVC = TermPickerViewController()
            navigationController?.pushViewController(goalVC, animated: true)
            textField.resignFirstResponder()
        } else {
            categoryAllocationModalView.scrollView.setContentOffset(CGPoint.init(x: 0, y: UIScreen.main.bounds.height/3), animated: true)
        }
    }
    
    private func textFieldDidEndEditing(textField: UITextField!) {
        categoryAllocationModalView.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        
        self.view.endEditing(true);
    }
    
    
}
