//
//  SimpleGoalCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class SimpleGoalCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "simpleGoalCollectionViewCell"

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
    
    lazy var iconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.anchor(width: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var upperVerticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Title Label"
        label.font = .bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dueDateLabel = {
        let label = UILabel()
        label.text = "MM/YYYY"
        label.font = .caption1Bold
        label.textColor = .secondary7
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
    
    lazy var tujuanLabel = {
        let label = UILabel()
        label.text = "Tujuan"
        label.font = .caption1Medium
        label.textColor = .black8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var targetAmountLabel = {
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
        contentView.backgroundColor = .secondary1
        contentView.layer.cornerRadius = 16
        
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        let viewMargins = contentView.layoutMarginsGuide
        
        contentView.addSubview(rootVerticalStackView)
        rootVerticalStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        rootVerticalStackView.addArrangedSubview(upperHorizontalStackView)
        
        upperHorizontalStackView.addArrangedSubview(iconLabel)
        upperHorizontalStackView.addArrangedSubview(upperVerticalStackView)
        
        upperVerticalStackView.addArrangedSubview(titleLabel)
        upperVerticalStackView.addArrangedSubview(dueDateLabel)
        
        rootVerticalStackView.addArrangedSubview(lowerVerticalStackView)
        lowerVerticalStackView.addArrangedSubview(tujuanLabel)
        lowerVerticalStackView.addArrangedSubview(targetAmountLabel)
    }
}
