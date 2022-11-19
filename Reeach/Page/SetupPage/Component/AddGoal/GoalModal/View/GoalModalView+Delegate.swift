//
//  GoalModalView+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension GoalModalView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == goalType.textField {
            return false
        }
        else if textField == iconView.iconTextField {
            textField.text = "\(textField.text?.onlyEmoji().prefix(0) ?? "")"
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == goalType.textField {
            viewDelegate?.goToTermPicker()
            textField.resignFirstResponder()
        }
        else {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: UIScreen.main.bounds.height/3), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        iconView.iconTextField.isUserInteractionEnabled = false
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        textFieldsIsNotEmpty(textField)
        dismissKeyboard()
    }
}
