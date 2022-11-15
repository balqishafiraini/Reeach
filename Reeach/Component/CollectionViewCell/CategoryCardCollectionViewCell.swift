//
//  CategoryCardCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import UIKit

class CategoryCardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "categoryCardCollectionViewCell"
    
    var category: Category?
    
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
    
    lazy var iconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.anchor(width: 28)
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
    
    private lazy var upperVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var middleRightVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
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
    
    private lazy var lowerVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        return stackView
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
        
        contentView.addSubview(rootVerticalStackView)
        rootVerticalStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        rootVerticalStackView.addArrangedSubview(upperHorizontalStackView)
        rootVerticalStackView.addArrangedSubview(middleHorizontalStackView)
        rootVerticalStackView.addArrangedSubview(lowerVerticalStackView)
        
        upperHorizontalStackView.addArrangedSubview(iconContainerView)
        upperHorizontalStackView.addArrangedSubview(upperVerticalStackView)
        iconContainerView.addSubview(iconLabel)
        iconLabel.center(inView: iconContainerView)
        
        upperVerticalStackView.addArrangedSubview(UIView())
        upperVerticalStackView.addArrangedSubview(titleLabel)
        upperVerticalStackView.addArrangedSubview(descriptionLabel)
        upperVerticalStackView.addArrangedSubview(UIView())
        
        middleHorizontalStackView.addArrangedSubview(middleLeftVerticalStackView)
        middleHorizontalStackView.addArrangedSubview(middleRightVerticalStackView)
        
        middleRightVerticalStackView.addArrangedSubview(middleRightTitleLabel)
        middleRightVerticalStackView.addArrangedSubview(middleRightValueLabel)
    }
    
    func configureContent() {
        if category?.type == "Goal" {
            let goal = category as? Goal
            
            iconContainerView.backgroundColor = .secondary2
            iconLabel.text = goal?.icon
            titleLabel.text = goal?.name
            descriptionLabel.text = DateFormatHelper.getShortMonthAndYearString(from: goal?.dueDate ?? Date())
            descriptionLabel.textColor = .secondary7
            middleRightTitleLabel.text = "Total Goal"
            middleRightValueLabel.text = CurrencyHelper.getCurrency(from: goal?.targetAmount ?? 0)
        }
        else {
            iconContainerView.backgroundColor = category?.type == "Need" ? .primary4 : .accentRed4
            descriptionLabel.textColor = .black8
            middleRightTitleLabel.text = "Sisa budget"
        }
    }
}
