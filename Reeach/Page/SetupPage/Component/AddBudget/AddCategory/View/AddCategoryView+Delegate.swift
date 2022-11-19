//
//  AddCategoryView+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension AddCategoryView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        iconTextField.isUserInteractionEnabled = false
        
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        
        configureButtonColor()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == iconTextField {
            textField.text = "\(textField.text?.onlyEmoji().prefix(0) ?? "")"
        }
        return true
    }
}
