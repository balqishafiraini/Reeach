//
//  TypePickerView.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TypePickerView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .ghostWhite
        cv.register(FilterItemCollectionViewCell.self, forCellWithReuseIdentifier: FilterItemCollectionViewCell.identifier)
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .ghostWhite
        self.addSubview(collectionView)
        collectionView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
}
