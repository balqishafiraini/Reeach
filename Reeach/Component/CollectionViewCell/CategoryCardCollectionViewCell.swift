//
//  CategoryCardCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import UIKit

class CategoryCardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "categoryCardCollectionViewCell"
    
    var goal: Goal?
    var budget: Budget?
    
    private lazy var rootVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var upperHorizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var iconContainerView = {
        let view = UIView()
        view.anchor(width: 52, height: 52)
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var upperVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var iconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.anchor(width: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Title Label"
        label.font = .bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .caption1Bold
        label.textColor = .secondary7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusContainerView = UIView()
    
    private lazy var statusLabelBackgroundView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .accentGreen
        return view
    }()
    
    lazy var statusLabel = {
        let label = UILabel()
        label.text = "Masih Aman 🥳"
        label.font = .caption2SemiBold
        label.textColor = .ghostWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var middleHorizontalStackViewContainerView = UIView()
    
    private lazy var middleHorizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var middleLeftVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var middleLeftTitleLabel = {
        let label = UILabel()
        label.text = "Left Title"
        label.font = .caption1Medium
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var middleLeftValueLabel = {
        let label = UILabel()
        label.text = "Rpxxx"
        label.font = .bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var middleRightVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var middleRightTitleLabel = {
        let label = UILabel()
        label.text = "Right Title"
        label.font = .caption1Medium
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var middleRightValueLabel = {
        let label = UILabel()
        label.text = "Rpxxx"
        label.font = .bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lowerVerticalStackViewContainerView = UIView()
    
    private lazy var lowerVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .black5
        progressView.layer.cornerRadius = 7
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 7
        progressView.subviews[1].clipsToBounds = true
        progressView.anchor(height: 12)
        return progressView
    }()
    
    lazy var lowerHorizontalStackViewContainerView = UIView()
    
    private lazy var lowerHorizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var lowerTitleLabel = {
        let label = UILabel()
        label.text = "Lower Title "
        label.font = .caption1Medium
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lowerValueLabel = {
        let label = UILabel()
        label.text = "Value"
        label.font = .caption1Bold
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 188)
    
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
        
        heightConstraint.isActive = true
        contentView.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        contentView.addSubview(rootVerticalStackView)
        rootVerticalStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        rootVerticalStackView.addArrangedSubview(upperHorizontalStackView)
        rootVerticalStackView.addArrangedSubview(middleHorizontalStackViewContainerView)
        rootVerticalStackView.addArrangedSubview(lowerVerticalStackViewContainerView)
        
        upperHorizontalStackView.addArrangedSubview(iconContainerView)
        upperHorizontalStackView.addArrangedSubview(upperVerticalStackView)
        upperHorizontalStackView.addArrangedSubview(UIView())
        upperHorizontalStackView.addArrangedSubview(statusContainerView)
        
        iconContainerView.addSubview(iconLabel)
        iconLabel.center(inView: iconContainerView)
        
        upperVerticalStackView.addArrangedSubview(UIView())
        upperVerticalStackView.addArrangedSubview(titleLabel)
        upperVerticalStackView.addArrangedSubview(descriptionLabel)
        upperVerticalStackView.addArrangedSubview(UIView())
        
        statusContainerView.addSubview(statusLabelBackgroundView)
        statusLabelBackgroundView.anchor(left: statusContainerView.leftAnchor, right: statusContainerView.rightAnchor)
        statusLabelBackgroundView.centerY(inView: statusContainerView)
        
        statusLabelBackgroundView.addSubview(statusLabel)
        statusLabel.anchor(top: statusLabelBackgroundView.topAnchor, left: statusLabelBackgroundView.leftAnchor, bottom: statusLabelBackgroundView.bottomAnchor, right: statusLabelBackgroundView.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        middleHorizontalStackViewContainerView.addSubview(middleHorizontalStackView)
        middleHorizontalStackView.anchor(top: middleHorizontalStackViewContainerView.topAnchor, left: middleHorizontalStackViewContainerView.leftAnchor, bottom: middleHorizontalStackViewContainerView.bottomAnchor, right: middleHorizontalStackViewContainerView.rightAnchor, paddingTop: 12)
        
        middleHorizontalStackView.addArrangedSubview(middleLeftVerticalStackView)
        middleHorizontalStackView.addArrangedSubview(UIView())
        middleHorizontalStackView.addArrangedSubview(middleRightVerticalStackView)
        
        middleLeftVerticalStackView.addArrangedSubview(middleLeftTitleLabel)
        middleLeftVerticalStackView.addArrangedSubview(middleLeftValueLabel)
        
        middleRightVerticalStackView.addArrangedSubview(middleRightTitleLabel)
        middleRightVerticalStackView.addArrangedSubview(middleRightValueLabel)
        
        lowerVerticalStackViewContainerView.addSubview(lowerVerticalStackView)
        lowerVerticalStackView.anchor(top: lowerVerticalStackViewContainerView.topAnchor, left: lowerVerticalStackViewContainerView.leftAnchor, bottom: lowerVerticalStackViewContainerView.bottomAnchor, right: lowerVerticalStackViewContainerView.rightAnchor, paddingTop: 20)
        
        lowerVerticalStackView.addArrangedSubview(progressView)
        lowerVerticalStackView.addArrangedSubview(lowerHorizontalStackViewContainerView)
        
        lowerHorizontalStackViewContainerView.addSubview(lowerHorizontalStackView)
        lowerHorizontalStackView.anchor(top: lowerHorizontalStackViewContainerView.topAnchor, bottom: lowerHorizontalStackViewContainerView.bottomAnchor)
        lowerHorizontalStackView.centerX(inView: lowerHorizontalStackViewContainerView)
        
        lowerHorizontalStackView.addArrangedSubview(lowerTitleLabel)
        lowerHorizontalStackView.addArrangedSubview(lowerValueLabel)
    }
    
    func configureContent() {
        if let goal {
            statusContainerView.isHidden = true
            
            iconContainerView.backgroundColor = .secondary2
            iconLabel.text = goal.icon
            
            titleLabel.text = goal.name
            descriptionLabel.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
            descriptionLabel.textColor = .secondary7
            
            middleLeftTitleLabel.text = "Terkumpul"
            middleLeftValueLabel.text = CurrencyHelper.getCurrency(from: goal.initialSaving(before: Date()))
            
            middleRightTitleLabel.text = "Total Goal"
            middleRightValueLabel.text = CurrencyHelper.getCurrency(from: goal.targetAmount)
            
            progressView.setProgress(Float(goal.initialSaving(before: Date())/goal.targetAmount), animated: true)
            lowerTitleLabel.text = "Kamu bisa mencapai goal ini pada "
            
            if goal.isActive(on: Date()) {
                lowerVerticalStackViewContainerView.isHidden = false
                let currentBudget = DatabaseHelper.shared.getBudget(on: Date(), of: goal)!
                let deadline = goal.recommendedDeadline(of: currentBudget, from: Date())
                
                lowerValueLabel.text = DateFormatHelper.getShortMonthAndYearString(from: deadline ?? Date())
            }
            else {
                lowerVerticalStackViewContainerView.isHidden = true
            }
            
        }
        else {
            statusContainerView.isHidden = false
            lowerVerticalStackViewContainerView.isHidden = false
            
            let isNeed = budget?.category?.type == "Need"
            
            iconContainerView.backgroundColor = isNeed ? .primary4 : .accentRed4
            iconLabel.text = budget?.category?.icon
            
            titleLabel.text = budget?.category?.name
            descriptionLabel.text = isNeed ? "Pokok" : "Nonpokok"
            descriptionLabel.textColor = .black7
            
            let isOverBudget = budget?.allocatedRatio ?? 0 > 1.0
            
            statusLabel.text = isOverBudget ? "Gawat!! 😱" : "Masih Aman 🥳"
            statusLabelBackgroundView.backgroundColor = isOverBudget ? .red6 : .accentGreen
            
            middleLeftTitleLabel.text = "Total budget"
            middleLeftValueLabel.text = CurrencyHelper.getCurrency(from: budget?.monthlyAllocation ?? 0)
            
            var totalUsage = 0.0
            let transactions = budget?.transactions?.allObjects as! [Transaction]
            for transaction in transactions {
                totalUsage += transaction.amount
            }
            
            middleRightTitleLabel.text = "Sisa budget"
            middleRightValueLabel.text = CurrencyHelper.getCurrency(from: (budget?.monthlyAllocation ?? 0) - totalUsage)
            
            progressView.tintColor = .accentGreen
            progressView.setProgress(Float(1 - (budget?.allocatedRatio ?? 0)), animated: false)
            
            lowerTitleLabel.text = "Sudah terpakai "
            lowerValueLabel.text = CurrencyHelper.getCurrency(from: totalUsage)
        }
    }
}
