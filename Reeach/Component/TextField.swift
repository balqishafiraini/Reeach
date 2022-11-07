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

    
    init(frame: CGRect, title: String? = nil, style: BorderStyle, prefix: String? = nil, icon: UIImage? = nil) {
        self.style = style
        super.init(frame: frame)
        setTitle(title: title ?? "")
        
        if let _ = prefix {
            makePrefix(prefix: prefix!)
        }
        
        if let _ = icon {
            makeIcon(icon: icon!)
        }
        
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
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        
        let height = textField.font!.pointSize * 2.3
        textField.anchor(height: height)
    }
    
    private class InputTextField: UITextField {
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            if let _ = self.leftView {
                return bounds.insetBy(dx: 40, dy: 0)
            }
            
            return bounds.insetBy(dx: 20, dy: 0)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            if let _ = self.leftView {
                return bounds.insetBy(dx: 40, dy: 0)
            }
            
            return bounds.insetBy(dx: 20, dy: 0)
        }
    }
    
    func makePrefix(prefix: String){
        let prefix: UILabel = {
            let label = PaddingLabel()
            label.text = prefix
            label.font = .bodyMedium
            label.textColor = .darkSlateGrey
            label.paddingLeft = 12

            return label
        }()
        
        textField.leftView = prefix
        textField.leftViewMode = .always
    }
    
    func makeIcon(icon: UIImage) {
        let icon: UIImageView = {
           let iconImage = UIImageView()
            iconImage.image = icon
            iconImage.tintColor = .darkSlateGrey
            iconImage.translatesAutoresizingMaskIntoConstraints = false
            return iconImage
        }()
        
        textField.rightView = icon
        textField.rightViewMode = .always
    }
}
