//
//  TextField.swift
//  Reeach
//
//  Created by Balqis on 19/10/22.
//

import UIKit

class TextField: UIView {
    
    // textField
    let textField:UITextField = {
        let tf = InputTextField()
        
        return tf
    }()

    enum BorderStyle {
        case template
        case active
        case error
    }
    
    public private(set) var style: BorderStyle

    
    init(frame: CGRect, title: String? = nil, style: BorderStyle) {
        self.style = style
        super.init(frame: frame)
        setTitle(title: title)
        textFieldSetup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textFieldSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        handleStyleTextField()
    }
    
    private func handleStyleTextField() {
        styleTF()
        switch style {
        case .template:
            textField.borderStyle = .none
        case .active:
            textField.layer.borderWidth = 1.5
            textField.layer.borderColor = UIColor.royalHunterBlue?.cgColor
        case .error:
            textField.layer.borderWidth = 1.5
            textField.layer.borderColor = UIColor.crimson?.cgColor
        }
    }
    
    private func styleTF() {
        textField.font = .bodyMedium
        textField.layer.cornerRadius = 8
        textField.backgroundColor = UIColor(named: "neutral4")
        textField.textColor = UIColor.darkSlateGrey
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
    }
    
    // label
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
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: textField.topAnchor, right: self.rightAnchor)

        textField.anchor(top: titleLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        let height = textField.font!.pointSize * 2.3
        textField.anchor(height: height)
    }
    
    private class InputTextField: UITextField {
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 20, dy: 0)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 20, dy: 0)
        }
    }
}
