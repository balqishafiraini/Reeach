//
//  CategoryAllocationModalView+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension CategoryAllocationModalView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == category.textField {
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == category.textField {
            viewDelegate?.goToSelectCategory()
            textField.resignFirstResponder()
        }
        else {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: UIScreen.main.bounds.height/3), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        if textField == monthlyAllocation.textField {
            viewDelegate?.validate(monthlyAllocation: Double(textField.text ?? "") ?? 0)
        }
        
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        textFieldsIsNotEmpty(textField)
        dismissKeyboard()
    }
}
