//
//  TransactionItem.swift
//  Reeach
//
//  Created by James Christian Wira on 01/12/22.
//

import UIKit

class TransactionItemViewCell: UICollectionViewCell {

    static let identifier = "transactionItemViewCell"
    
    var transaction: Transaction?
    
    lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        label.backgroundColor = .secondary2
        
        return label
    }()
    
    lazy var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondary2
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        
        view.addSubview(iconLabel)
        view.anchor(width: 44, height: 44)
        iconLabel.center(inView: view)
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1Bold
        label.textColor = .black7
        
        return label
    }()
    
    lazy var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        label.textAlignment = .right
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
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
    
    init(frame: CGRect, transaction: Transaction) {
        super.init(frame: frame)
        
        setupData(transaction: transaction)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(transaction: Transaction) {
        self.transaction = transaction
        iconLabel.text = transaction.budget?.category?.icon
        titleLabel.text = transaction.name
        subtitleLabel.text = transaction.budget?.category?.name
        amountLabel.text = CurrencyHelper.getCurrency(from: transaction.amount)
        
        switch transaction.budget?.category?.type {
        case "Goal":
            iconLabel.backgroundColor = .secondary2
        case "Need":
            iconLabel.backgroundColor = .primary4
        case "Want":
            iconLabel.backgroundColor = .accentRed4
        case "Income":
            iconLabel.backgroundColor = .secondary2
        default:
            iconLabel.backgroundColor = .black3
        }
    }
    
    lazy var containerLeftConstraint = container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
    lazy var containerRightConstraint = container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
    
    func setupView() {
        self.addSubview(container)
        container.addSubview(stackView)
        
        detailStack.addArrangedSubview(titleLabel)
        detailStack.addArrangedSubview(subtitleLabel)
        
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(detailStack)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(amountLabel)
        
        stackView.setCustomSpacing(12, after: iconView)
        
        container.anchor(top: self.topAnchor, bottom: self.bottomAnchor)
        containerLeftConstraint.isActive = true
        containerRightConstraint.isActive = true
        
        stackView.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12)
        
    }
}
