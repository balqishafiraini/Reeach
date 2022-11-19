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
        
        return label
    }()
    
    let incomeTextField: TextField = {
        let textField = TextField(frame: .zero, style: .active)
        textField.textField.keyboardType = .numberPad
        
        return textField
    }()
    
    let headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        
        return stack
    }()
    
    let contentStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    let goalStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        
        let label = UILabel()
        label.text = "Goal"
        label.font = .headline
        
        let addButton = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(addButton)
        
        return stack
    }()
    
    func setupView() {
        if let income = income {
            incomeTextField.textField.text = "\(income)"
        }
        
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        headerStack.addArrangedSubview(incomeTextField)
        
        contentStack.addArrangedSubview(headerStack)
        
        self.addSubview(contentStack)
        
        contentStack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        setupTargetsAndActions()
    }
    
    func setupTargetsAndActions() {        
        incomeTextField.textField.addTarget(self, action: #selector(saveIncome), for: .editingDidEnd)
        incomeTextField.textField.sendActions(for: .valueChanged)
    }
    
    @objc func saveIncome() {
        delegate?.saveIncome?(income: incomeTextField.textField.text ?? "0.0")
    }
    
    @objc func prevStep() {
        delegate?.previousProgress!()
    }
}
