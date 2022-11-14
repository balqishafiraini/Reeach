//
//  GoalAllocationView.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class CategoryAllocationModalView: UIView {
        
    let iconWithoutEdit = IconWithoutEditView()
    
    let category = TextField(frame: .zero, title: "Kategori", style: .template, icon: UIImage(systemName: "greaterthan"))
    
    let monthlyAllocation = TextField(frame: .zero, title: "Alokasi Bulanan", style: .template, prefix: "Rp")
    
    let saveButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Simpan")

    lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            return scrollView
        }()
    
    
    func configureStackView() {
        self.backgroundColor = .ghostWhite
        
        let vstack = UIStackView(arrangedSubviews: [iconWithoutEdit,
                                                    category,
                                                    monthlyAllocation,
                                                   saveButton]
        )
        
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 16
        
        
        //autolayout
        self.addSubview(scrollView)
        scrollView.addSubview(vstack)
        
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, width: UIScreen.main.bounds.width)
        
        vstack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        NSLayoutConstraint.activate([
            vstack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        iconWithoutEdit.setUp()
        iconWithoutEdit.anchor(top: vstack.topAnchor, paddingTop: 20)
        iconWithoutEdit.heightAnchor.constraint(equalTo: iconWithoutEdit.iconLabel.heightAnchor).isActive = true
        
    }

}

class IconWithoutEditView: UIView {
    let iconLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Tambah icon"
        label.textAlignment = .center
        label.textColor = .royalHunterBlue
        label.font = .bodyMedium
        label.backgroundColor = .secondary2
        label.layer.cornerRadius = 75
        label.layer.masksToBounds = true
        return label
    }()
    
    
    func setUp() {
        //auto-layout
        
        addSubview(iconLabel)
        
        iconLabel.centerX(inView: self)
        
        iconLabel.anchor(width: 150, height: 150)
    }
}
