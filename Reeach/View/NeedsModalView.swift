//
//  NeedsModalView.swift
//  Reeach
//
//  Created by Balqis on 02/11/22.
//

import UIKit

class NeedsModalView: UIView {
    
    func configureStackView() {
        
        let cancelButton: UIButton = {
            let button = UIButton()
            button.setTitle("Batal", for: .normal)
            button.setTitleColor(UIColor.crimson, for: .normal)
            button.backgroundColor = .clear
            button.contentHorizontalAlignment = .left
            return button
        }()
        
        let addGoal: UILabel = {
            let label = UILabel()
            label.text = "Kebutuhan Pokok"
            label.font = .bodyBold
            return label
        }()
        
        let saveButton: UIButton = {
            let button = UIButton()
            button.setTitle("Simpan", for: .normal)
            button.setTitleColor(UIColor.royalHunterBlue, for: .normal)
            button.backgroundColor = .clear
            button.contentHorizontalAlignment = .right
            return button
        }()
        
        let iconView = IconView()
        iconView.setUp()
        let hstack = UIStackView(arrangedSubviews: [cancelButton, addGoal, saveButton])
        hstack.frame = self.bounds
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.spacing = 10
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        let category = TextField(frame: .zero, title: "Kategori", style: .template)
        
        let monthlyAllocation = TextField(frame: .zero, title: "Alokasi Bulanan", style: .template)
        
       
        
       
        
        let vstack = UIStackView(arrangedSubviews: [hstack,
                                                    iconView,
                                                    category, monthlyAllocation])
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 20
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(vstack)
        
        vstack.backgroundColor = .white
        
        hstack.anchor(top:self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 12,paddingLeft: 20, paddingRight: 20)
        
        vstack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        //        iconView.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor)
        
        category.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        monthlyAllocation.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
}
