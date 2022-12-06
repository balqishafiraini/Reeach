//
//  DatePicker.swift
//  Reeach
//
//  Created by Balqis on 25/10/22.
//

import UIKit

class DatePicker: UIView, UITextFieldDelegate {
    
    var date: Date? = Date()
    
    lazy var datePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        
        datePicker.addTarget(self, action: #selector(openDatePicker), for: .valueChanged)
        
        return datePicker
    }()
    
    lazy var textField: TextField = {
        let tf = TextField(frame: .zero, style: .template, icon: UIImage(named: "Calendar"))
        tf.textField.placeholder = "MM/YYYY"
        tf.tintColor = .clear
        tf.textField.delegate = self
        tf.textField.inputView = datePicker
        return tf
    }()
    
    /*
     taro ini di view controller yg manggil dia
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.endEditing(true)
        }
     */
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        setTitle(title: title)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: textField.topAnchor, right: self.rightAnchor)
        titleLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)

        textField.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    @objc func openDatePicker(sender: UIDatePicker) {
        date = sender.date
        
        textField.textField.text = DateFormatHelper.getShortMonthAndYearString(from: sender.date)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
