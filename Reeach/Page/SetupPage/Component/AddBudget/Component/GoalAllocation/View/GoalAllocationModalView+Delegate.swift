//
//  GoalAllocationModalView+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension GoalAllocationModalView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        blankViewHeightConstraint.constant = UIScreen.main.bounds.height/3
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        textFieldsIsNotEmpty(textField)
        blankViewHeightConstraint.constant = 0
        dismissKeyboard()
    }
}
