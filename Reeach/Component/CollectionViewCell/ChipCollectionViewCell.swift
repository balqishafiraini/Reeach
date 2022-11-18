//
//  ChipCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "chipCollectionViewCell"
    
    enum Style {
        case active
        case inactive
    }
    
    var style: Style = .inactive
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .bodyMedium
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
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.secondary?.cgColor
        contentView.layer.borderWidth = 1
        configureAutoLayout()
        configureActiveView()
    }
    
    func configureAutoLayout() {
        let viewMargins = safeAreaLayoutGuide
        addSubview(titleLabel)
        titleLabel.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
    }
    
    func setIsActive(_ style: Style){
        self.style = style
        configureActiveView()
    }
    
    func configureActiveView() {
        contentView.backgroundColor = style == .active ? .secondary : .white
        titleLabel.textColor = style == .active ? .white : .secondary
    }
}
