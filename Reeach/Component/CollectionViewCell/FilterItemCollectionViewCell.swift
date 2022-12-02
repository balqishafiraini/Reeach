//
//  FilterItemCollectionViewCell.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import Foundation
import UIKit

class FilterItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "filterItemCollectionViewCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .black13
        
        return label
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .cardColor
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(label: String) {
        self.label.text = label
    }
    
    func setupView() {
        container.addSubview(label)
        
        self.addSubview(container)
        
        container.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        label.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12)
        
    }
}
