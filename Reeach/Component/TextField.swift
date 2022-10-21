//
//  TextField.swift
//  Reeach
//
//  Created by Balqis on 19/10/22.
//

import UIKit

class InputField: UIView {
    
    // textField
    let textField = UITextField()

    enum BorderStyle {
        case template
        case active
        case error
    }
    
    public private(set) var style: BorderStyle
    
    init(title: String, style: BorderStyle) {
        self.style = style
        super.init(frame: .zero)
        setTitle(title: title)
        textFieldsetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textFieldsetup() {
        translatesAutoresizingMaskIntoConstraints = false
        handleStyleTextField()
    }
    
    private func handleStyleTextField() {
        switch style {
        case .template:
            textField.borderStyle = .none
            styleTF()
        case .active:
            textField.borderStyle = .line
            layer.borderColor = UIColor.royalHunterBlue?.cgColor
            styleTF()
        case .error:
            textField.borderStyle = .line
            layer.borderColor = UIColor.crimson?.cgColor
            styleTF()
        }
    }
    
    private func styleTF() {
        textField.backgroundColor = UIColor(named: "neutral4")
        textField.textColor = UIColor(named: "neutral13")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
    }
    
    // label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setTitle(title: String) {
        titleLabel.text = title.uppercased()
    }
    
    private func configure() {
        addSubview(textField)
        addSubview(titleLabel)
    }
}
