//
//  GoalAllocationView.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class CategoryAllocationModalView: UIView {
    
    let iconWithoutEdit = IconWithoutEditView()
    
    let category = {
        let tf = TextField(frame: .zero, title: "Kategori", style: .template, icon: UIImage(named: "ChevronRight"))
        tf.textField.placeholder = "Pilih Kategori"
        return tf
    }()
    
    let monthlyAllocation = TextField(frame: .zero, title: "Alokasi Bulanan", style: .template, prefix: "Rp")
    
    let deleteButton = {
        let btn = Button(style: .rounded, foreground: .destructive, background: .darkSlateGrey, title: "Hapus Kebutuhan")
        btn.backgroundColor = .red6
        btn.setTitleColor(UIColor.ghostWhite, for: .normal)
        return btn
    }()
    
    let saveButton = {
        let btn = Button(style: .rounded, foreground: .destructive, background: .darkSlateGrey, title: "Simpan")
        btn.backgroundColor = .black4
        btn.setTitleColor(UIColor.black7, for: .normal)
        return btn
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    
    func configureStackView() {
        self.backgroundColor = .ghostWhite
        

        let vstack = UIStackView(arrangedSubviews: [iconWithoutEdit, category, monthlyAllocation]
        )
        
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 16
        
        let buttonStackView = UIStackView(arrangedSubviews: [saveButton, deleteButton])
        buttonStackView.frame = self.bounds
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [vstack, buttonStackView])
        stackView.frame = self.bounds
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        //autolayout
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
        
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        NSLayoutConstraint.activate([
                    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
                    stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                ])

        iconWithoutEdit.setUp()
        iconWithoutEdit.anchor(top: vstack.topAnchor, paddingTop: 20)
        iconWithoutEdit.heightAnchor.constraint(equalTo: iconWithoutEdit.iconLabel.heightAnchor).isActive = true
        
    }
    
}
