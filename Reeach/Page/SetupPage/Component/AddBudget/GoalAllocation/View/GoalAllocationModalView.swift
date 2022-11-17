//
//  GoalAllocationModalView.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import Foundation
import UIKit

class GoalAllocationModalView: UIView {
    
    let iconWithoutEdit = IconWithoutEditView()
    
    let goalName = TextField(frame: .zero, title: "Judul", style: .template)
    
    let dueDate = DatePicker(frame: .zero, title: "Deadline")
    
    let target = TextField(frame: .zero, title: "Target Terkumpul", style: .template, prefix: "Rp")
    
    let inflationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        button.tintColor = .royalHunterBlue
        button.setTitle("WATCH OUT! Nilai setelah inflasi: ", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        button.setTitleColor(.royalHunterBlue, for: .normal)
        button.titleLabel?.font = .caption1Bold
        button.titleLabel?.textAlignment = .left
        button.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        return button
    }()
    
    let monthlySaving = TextField(frame: .zero, title: "Tabungan Bulanan", style: .template, prefix: "Rp")
    
    let budgetRemain: UILabel = {
        let label = UILabel()
        label.text = "Sisa anggaran yang harus dialokasikan"
        label.textColor = .black13
        label.font = .caption1Medium
        return label
    }()
    
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
    
    
    //scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    
    func configureStackView() {
        self.backgroundColor = .ghostWhite
        
        let vstack = UIStackView(arrangedSubviews: [iconWithoutEdit, goalName, dueDate, target, inflationButton, monthlySaving, budgetRemain]
        )
        
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 16
        vstack.setCustomSpacing(12, after: target)
        vstack.setCustomSpacing(12, after: monthlySaving)
        
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
    
    /*
     func configureStackView() {
     self.backgroundColor = .ghostWhite
     
     let vstack = UIStackView(arrangedSubviews: [iconWithoutEdit,
     goalName,
     dueDate,
     target,
     inflationButton,
     monthlySaving,
     budgetRemain,
     saveButton]
     )
     
     vstack.frame = self.bounds
     vstack.axis = .vertical
     vstack.distribution = .fill
     vstack.spacing = 16
     vstack.setCustomSpacing(12, after: target)
     vstack.setCustomSpacing(12, after: monthlySaving)
     
     
     //autolayout
     self.addSubview(scrollView)
     scrollView.addSubview(vstack)
     
     scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width)
     
     vstack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingRight: 20)
     
     NSLayoutConstraint.activate([
     vstack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
     ])
     
     iconWithoutEdit.setUp()
     iconWithoutEdit.heightAnchor.constraint(equalTo: iconWithoutEdit.iconLabel.heightAnchor).isActive = true
     
     }
     */
}

