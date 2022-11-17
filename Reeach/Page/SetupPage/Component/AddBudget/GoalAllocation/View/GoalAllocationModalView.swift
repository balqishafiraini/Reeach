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
    
    let saveButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Simpan")


    
    //scrollView
    lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            return scrollView
        }()
    
    
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
}

