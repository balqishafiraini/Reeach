//
//  BudgetNeedsModalView.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class BudgetNeedsModalView: UIView {
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Batal", for: .normal)
        button.setTitleColor(UIColor.crimson, for: .normal)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let goalAllocationTitle: UILabel = {
        let label = UILabel()
        label.text = "Alokasi Goal"
        label.textAlignment = .center
        label.font = .bodyBold
        label.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        return label
    }()
    
    
    let iconWithoutEdit = IconWithoutEditView()
    
    let category = TextField(frame: .zero, title: "Kategori", style: .template, icon: "greaterthan")
    
    let monthlyAllocation = TextField(frame: .zero, title: "Alokasi Bulanan", style: .template, prefix: "Rp")
    
    let saveButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Simpan")


    
    //scrollView
    lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            return scrollView
        }()
    
    
    func configureStackView() {
        self.backgroundColor = .ghostWhite
        
        let navHstack = UIStackView(arrangedSubviews: [cancelButton, goalAllocationTitle])
        navHstack.frame = self.bounds
        navHstack.axis = .horizontal
        navHstack.distribution = .fill
        
        let vstack = UIStackView(arrangedSubviews: [iconWithoutEdit,
                                                    category,
                                                    monthlyAllocation,
                                                   saveButton]
        )
        
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 16
        vstack.setCustomSpacing(12, after: target)
        vstack.setCustomSpacing(12, after: monthlySaving)

        
        //autolayout
        scrollView.addSubview(vstack)
        
        self.addSubview(navHstack)
        self.addSubview(scrollView)
        
        navHstack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 50)
        
        scrollView.anchor(top: navHstack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width)
        
        vstack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        NSLayoutConstraint.activate([
            vstack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        iconWithoutEdit.setUp()
        iconWithoutEdit.heightAnchor.constraint(equalTo: iconWithoutEdit.iconLabel.heightAnchor).isActive = true
        
        goalAllocationTitle.anchor(right: vstack.rightAnchor, paddingRight: UIScreen.main.bounds.width*0.325)
        
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
