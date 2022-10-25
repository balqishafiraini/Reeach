//
//  DatePicker.swift
//  Reeach
//
//  Created by Balqis on 25/10/22.
//

import UIKit

class DatePicker: UIView {
    
    lazy var tfPlaceholder: TextField = {
        let tf = TextField(title: "", style: .template)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
//        tf.inputView = datePicker
        
        
        datePicker.addTarget(self, action: #selector(self.valuechanged), for: .valueChanged)
        
        return tf
    }()
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        datePicker.hidden = false
        return false // <--- this is not letting the textField become editable
    }
    
}
