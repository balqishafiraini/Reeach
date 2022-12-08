//
//  CategoryBudgetSelectionView.swift
//  Reeach
//
//  Created by James Christian Wira on 08/12/22.
//

import UIKit

class CategoryBudgetSelectionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var budgetList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .ghostWhite
        cv.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: ChipCollectionViewCell.reuseIdentifier)
        
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
        
        self.addSubview(budgetList)
        
        budgetList.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor, paddingLeft: 20, paddingRight: 20)
        budgetList.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
    }
}
