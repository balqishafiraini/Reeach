//
//  GoalModalView.swift
//  Reeach
//
//  Created by Balqis on 01/11/22.
//

import Foundation
import UIKit

class GoalModalView: UIView {
    
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
            label.text = "Tambah Goal"
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
        
        let goalName = TextField(frame: .zero, title: "Judul Goal", style: .template)
        
        
        let recommendButton: UIButton = {
            let button = UIButton()
            button.setTitle("Bingung, guys? Lihat rekomendasinya di sini, kuy!", for: .normal)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .clear
            button.setTitleColor(.royalHunterBlue, for: .normal)
            button.titleLabel?.font = .caption1Bold
            button.titleLabel?.textAlignment = .left
            return button
        }()

        
        let dueDate = DatePicker(frame: .zero, title: "Deadline")
        
        let inflationButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
            button.setTitle("WATCH OUT! Nilai setelah inflasi: ", for: .normal)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .clear
            button.setTitleColor(.royalHunterBlue, for: .normal)
            button.titleLabel?.font = .caption1Bold
            button.titleLabel?.textAlignment = .left
            return button
        }()
        
        let total = TextField(frame: .zero, title: "Jumlah", style: .template)
        
        let goalType = TextField(frame: .zero, title: "Tipe Goal", style: .template)
        
        let iconView = IconView()
        iconView.setUp()
        let hstack = UIStackView(arrangedSubviews: [cancelButton, addGoal, saveButton])
        hstack.frame = self.bounds
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.spacing = 10
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        let vstack = UIStackView(arrangedSubviews: [hstack,
                                                    iconView,
                                                    goalName,
                                                    recommendButton,
                                                    dueDate,
                                                    total,
                                                    inflationButton,
                                                    goalType])
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
        
        goalName.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        recommendButton.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        dueDate.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        total.anchor(top: dueDate.topAnchor, left: vstack.leftAnchor, right: vstack.rightAnchor, paddingTop: 80, paddingLeft: 20, paddingRight: 20)
        
        inflationButton.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        goalType.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
}

class IconView: UIView {
    let iconLabel: UILabel = {
        
        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        label.text = "Tambah icon"
        label.textAlignment = .center
        label.textColor = .royalHunterBlue
        label.font = .bodyMedium
        label.backgroundColor = UIColor(named: "secondary2")
        label.layer.cornerRadius = 75
        label.layer.masksToBounds = true
        return label
    }()
    
    let iconButton: UIButton = {

        let button = UIButton()
        button.backgroundColor = .tangerineYellow
//        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.frame.size = CGSize(width: 10, height: 10)
        button.layer.cornerRadius = button.frame.height/2
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)
        let symbol = UIImage(systemName: "pencil", withConfiguration: config)
        button.setImage(symbol, for: .normal)
        return button
    }()

    func setUp() {
        //auto-layout
        
        addSubview(iconButton)
        addSubview(iconLabel)
        self.bringSubviewToFront(iconButton)
        
        iconButton.anchor(bottom: iconLabel.bottomAnchor, right: iconLabel.rightAnchor, paddingRight: 20)
        
        iconLabel.centerX(inView: self)
        
        iconLabel.anchor(width: 150, height: 150)
    }
}
