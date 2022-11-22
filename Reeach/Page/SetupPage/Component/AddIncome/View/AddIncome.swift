//
//  AddIncome.swift
//  Reeach
//
//  Created by James Christian Wira on 25/10/22.
//

import UIKit

class AddIncome: UIView {
    
    weak var delegate: SetupDelegate?
    var income: Double?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topTitle: UILabel = {
        let label = UILabel()
        label.text = "Pemasukan"
        label.font = .largeTitle
        
        label.anchor(height: 40)
        
        return label
    }()
    
    let viewDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Pemasukan adalah nominal yang kamu terima tiap bulannya ya, Bestie, bukan uang yang masih tersisa. Yuk, tulis pemasukanmu."
        label.font = .bodyMedium
        label.numberOfLines = 0
        label.textColor = .black8
        
        return label
    }()
    
    let incomeTextField: TextField = {
        let textField = TextField(frame: .zero, style: .template, prefix: "Rp ")
        textField.textField.keyboardType = .numberPad
        
        return textField
    }()
    
    let headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        
        return stack
    }()
    
    let contentStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    func setupView() {
        self.backgroundColor = .ghostWhite
        
        if let income = income {
            if income > 0.0 {
                incomeTextField.textField.text = "\(CurrencyHelper.getFormattedNumber(from: income))"
            }
        }
        
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        headerStack.addArrangedSubview(incomeTextField)
        
        contentStack.addArrangedSubview(headerStack)
        
        self.addSubview(contentStack)
        
        contentStack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        headerStack.setCustomSpacing(12, after: topTitle)
        
        setupTargetsAndActions()
    }
    
    func setupTargetsAndActions() {
        incomeTextField.textField.addTarget(self, action: #selector(saveIncome), for: .allEditingEvents)
        incomeTextField.textField.sendActions(for: .valueChanged)
    }
    
    @objc func saveIncome() {
        let textField = incomeTextField.textField
        let incomeString = (textField.text ?? "0.0").replacingOccurrences(of: ".", with: "")
        let incomeDouble = Double(incomeString) ?? 0.0
        
        textField.text = CurrencyHelper.getFormattedNumber(from: incomeDouble)
        
        delegate?.saveIncome?(income: textField.text ?? "0.0")
    }
    
    @objc func prevStep() {
        delegate?.previousProgress!()
    }
}
