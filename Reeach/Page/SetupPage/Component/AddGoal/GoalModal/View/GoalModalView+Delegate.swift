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
        /*
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = "."
        
        if let groupingSeparator = formatter.groupingSeparator {
            
            if string == groupingSeparator {
                return true
            }
            
            if let textWithoutGroupingSeparator = textField.text?.replacingOccurrences(of: groupingSeparator, with: "") {
                var totalTextWithoutGroupingSeparators = textWithoutGroupingSeparator + string
                if string.isEmpty {
                    totalTextWithoutGroupingSeparators.removeLast()
                }
                if let numberWithoutGroupingSeparator = formatter.number(from: totalTextWithoutGroupingSeparators),
                   let formattedText = formatter.string(from: numberWithoutGroupingSeparator) {
                    textField.text = formattedText
                    return false
                }
            }
        }
         */
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 400), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        iconView.iconTextField.isUserInteractionEnabled = false
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        textFieldsIsNotEmpty(textField)
        dismissKeyboard()
    }
}
