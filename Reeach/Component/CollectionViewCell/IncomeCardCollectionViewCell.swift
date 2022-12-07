//
//  IncomeCardCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 02/12/22.
//

import UIKit

class IncomeCardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "incomeCardCollectionViewCell"
    
    var budget: Budget?
    
    private lazy var rootHorizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "IllustrationIncome")
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 84, height: 84)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var verticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var expectedTitleLabel = {
        let label = UILabel()
        label.text = "Estimasi Pemasukan"
        label.font = .caption1Medium
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var expectedValueLabel = {
        let label = UILabel()
        label.text = "Rpxxx"
        label.font = .bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalTitleLabel = {
        let label = UILabel()
        label.text = "Total Pemasukan"
        label.font = .caption1Medium
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalValueLabel = {
        let label = UILabel()
        label.text = "Rpxxx"
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
        
        contentView.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        contentView.addSubview(rootHorizontalStackView)
        rootHorizontalStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        rootHorizontalStackView.addArrangedSubview(imageView)
        rootHorizontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(expectedTitleLabel)
        verticalStackView.addArrangedSubview(expectedValueLabel)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(totalTitleLabel)
        verticalStackView.addArrangedSubview(totalValueLabel)
    }
    
    func configureContent() {
        expectedValueLabel.text = CurrencyHelper.getCurrency(from: budget?.monthlyAllocation ?? 0)
        
        var total = 0.0
        let transactions = budget?.transactions?.allObjects as! [Transaction]
        
        for transaction in transactions {
            total += transaction.amount
        }
        totalValueLabel.text = CurrencyHelper.getCurrency(from: total)
    }
}
