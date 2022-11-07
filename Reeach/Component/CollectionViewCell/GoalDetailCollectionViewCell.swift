//
//  GoalDetailCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 02/11/22.
//

import UIKit

class GoalDetailCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "goalDetailCollectionViewCell"
    
    lazy var horizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var verticalStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var iconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
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
    
    lazy var detailLabel = {
        let label = UILabel()
        label.text = "Detail Label"
        label.numberOfLines = 0
        label.font = .bodyMedium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkMarkImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 22)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.secondary?.cgColor
        
        configureAutoLayout()
        configureSelectedView()
    }
    
    func configureAutoLayout() {
        let viewMargins = contentView.layoutMarginsGuide
        
        contentView.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        contentView.addSubview(horizontalStackView)
        horizontalStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4)
        
        horizontalStackView.addArrangedSubview(iconLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(checkMarkImageView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(detailLabel)
        titleLabel.widthAnchor.constraint(equalTo: detailLabel.widthAnchor).isActive = true
    }
    
    func configureSelectedView(){
        contentView.layer.borderWidth = isSelected == true ? 2 : 0
        checkMarkImageView.isHidden = !isSelected
    }
}
