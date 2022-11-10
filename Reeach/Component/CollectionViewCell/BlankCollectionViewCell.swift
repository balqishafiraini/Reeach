//
//  BlankCollectionViewCell.swift
//  Reeach
//
//  Created by William Chrisandy on 02/11/22.
//

import UIKit

class BlankCollectionViewCell: UICollectionViewCell {

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
        contentView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
}
