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
    
    func configureAutoLayout() {
        let viewMargins = safeAreaLayoutGuide
        addSubview(titleLabel)
        titleLabel.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 12, paddingRight: 20)
    }
}
