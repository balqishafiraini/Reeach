//
//  DatePicker.swift
//  Reeach
//
//  Created by Balqis on 25/10/22.
//

import UIKit

class DatePicker: UIView {
    
    var datePicker: TextField = {
        let tf = TextField(frame: .zero, style: .active)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        
        tf.textField.inputView = datePicker

        datePicker.addTarget(DatePicker.self, action: #selector(DatePicker.openDatePicker), for: .valueChanged)
        
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
        addSubview(datePicker)
        
        datePicker.centerX(inView: self)
        datePicker.anchor(width: UIScreen.main.bounds.width - 32)
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
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .none
        
        print(dateFormat.string(from: sender.date))
        
        datePicker.textField.text = dateFormat.string(from: sender.date)
    }
    
}
