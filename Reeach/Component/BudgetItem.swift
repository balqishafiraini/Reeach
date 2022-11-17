//
//  BudgetItem.swift
//  Reeach
//
//  Created by James Christian Wira on 18/11/22.
//

import UIKit

class BudgetItem: UIView {

    lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.text = "Tambah icon"
        label.textAlignment = .center
        label.textColor = .royalHunterBlue
        label.font = .bodyMedium
        label.backgroundColor = .secondary2
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .cardColor
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    init(frame: CGRect, icon: String, title: String, amount: Double) {
        super.init(frame: frame)
        iconLabel.text = icon
        titleLabel.text = title
        amountLabel.text = CurrencyHelper.getCurrency(from: amount)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(container)
        
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(iconLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(amountLabel)
        
        stackView.setCustomSpacing(12, after: iconLabel)
        
        container.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        iconLabel.anchor(width: 44, height: 44)
        stackView.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12)
    }
    
}
