//
//  AddButtonView.swift
//  Reeach
//
//  Created by Balqis on 05/12/22.
//

import UIKit

class AddButtonView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tambah Baru"
        label.font = .title
        label.textColor = .black13
        return label
    }()
    
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Close"), for: .normal)
        return btn
    }()
    
    let newGoal: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "IllustrationNewGoal"), for: .normal)
        btn.setTitle("Goal Baru", for: .normal)
        btn.titleLabel?.font = .bodyBold
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(.black13, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 100)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: -32)
        return btn
    }()
    
    let newTransaction: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "IllustrationNewTransaction"), for: .normal)
        btn.setTitle("Transaksi Baru", for: .normal)
        btn.titleLabel?.font = .bodyBold
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(.black13, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 80)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: -32)
        return btn
    }()
    
    func configureAutoLayout() {

        let navStackView = UIStackView(arrangedSubviews: [titleLabel, closeButton]
        )
        navStackView.frame = self.bounds
        navStackView.axis = .horizontal
        navStackView.distribution = .equalSpacing
        
        let btnStackView = UIStackView(arrangedSubviews: [newGoal, newTransaction]
        )
        btnStackView.frame = self.bounds
        btnStackView.axis = .vertical
        btnStackView.distribution = .fillEqually
        btnStackView.spacing = 20
        btnStackView.alignment = .leading
        
        
        backgroundColor = .ghostWhite
        
        addSubview(navStackView)
        navStackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 20, paddingRight: 20)
        addSubview(btnStackView)
        btnStackView.anchor(top: navStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)

    }
}
