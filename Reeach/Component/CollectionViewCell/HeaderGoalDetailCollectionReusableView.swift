//
//  HeaderGoalDetailCollectionReusableView.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

class HeaderGoalDetailCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "headerGoalDetailCollectionViewCell"
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .bodyBold
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
        backgroundColor = .clear
        configureAutoLayout()
    }
    
    lazy var titleLabelLeftAnchorConstraint = titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20)
    lazy var titleLabelRightAnchorConstraint = titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 20)
    
    func configureAutoLayout() {
        let viewMargins = safeAreaLayoutGuide
        addSubview(titleLabel)
        titleLabel.anchor(top: viewMargins.topAnchor, bottom: viewMargins.bottomAnchor, paddingTop: 16, paddingBottom: 12)
        titleLabelLeftAnchorConstraint.isActive = true
        titleLabelRightAnchorConstraint.isActive = true
    }
}
