//
//  SimpleBudgetCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 07/12/22.
//

import UIKit

class SimpleBudgetCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "simpleBudgetCollectionViewCell"

    var budget: Budget?
    
    private lazy var rootHorizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var iconContainerView = {
        let view = UIView()
        view.anchor(width: 44, height: 44)
        view.layer.cornerRadius = 22
        return view
    }()
    
    lazy var iconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.anchor(width: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftVerticalStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Title Label"
        label.font = .bodyMedium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel = {
        let label = UILabel()
        label.text = "Kebutuhan"
        label.font = .caption1Bold
        label.textColor = .black7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightVerticalStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .trailing
        return stackView
    }()
    
    lazy var remainingTitleLabel = {
        let label = UILabel()
        label.text = "Tersisa"
        label.font = .caption1Medium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var remainingValueLabel = {
        let label = UILabel()
        label.text = "Rpxxx,xx"
        label.font = .bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.backgroundColor = .cardColor
        contentView.layer.cornerRadius = 16
        
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        let viewMargins = contentView.layoutMarginsGuide
        
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        contentView.addSubview(rootHorizontalStackView)
        rootHorizontalStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4)
        
        rootHorizontalStackView.addArrangedSubview(iconContainerView)
        rootHorizontalStackView.addArrangedSubview(leftVerticalStackView)
        rootHorizontalStackView.addArrangedSubview(rightVerticalStackView)
        
        iconContainerView.addSubview(iconLabel)
        iconLabel.center(inView: iconContainerView)
        
        leftVerticalStackView.addArrangedSubview(UIView())
        leftVerticalStackView.addArrangedSubview(titleLabel)
        leftVerticalStackView.addArrangedSubview(descriptionLabel)
        leftVerticalStackView.addArrangedSubview(UIView())
        
        rightVerticalStackView.addArrangedSubview(UIView())
        rightVerticalStackView.addArrangedSubview(remainingTitleLabel)
        rightVerticalStackView.addArrangedSubview(remainingValueLabel)
        rightVerticalStackView.addArrangedSubview(UIView())
    }
    
    func configureContent() {
        if let budget {
            let isNeed = budget.category?.type == "Need"
            
            iconContainerView.backgroundColor = isNeed ? .primary4 : .accentRed4
            iconLabel.text = budget.category?.icon
            
            titleLabel.text = budget.category?.name
            descriptionLabel.text = isNeed ? "Pokok" : "Nonpokok"
            
            var totalUsage = 0.0
            let transactions = budget.transactions?.allObjects as! [Transaction]
            for transaction in transactions {
                totalUsage += transaction.amount
            }
            
            remainingValueLabel.text = CurrencyHelper.getCurrency(from: budget.monthlyAllocation - totalUsage)
        }
    }
}
