//
//  GoalModalView.swift
//  Reeach
//
//  Created by Balqis on 01/11/22.
//

import Foundation
import UIKit

class GoalModalView: UIView {
    
    let goalName = TextField(frame: .zero, title: "Judul Goal", style: .template)
    
    let recommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bingung, guys? Lihat rekomendasinya di sini, kuy!", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        button.setTitleColor(.royalHunterBlue, for: .normal)
        button.titleLabel?.font = .caption1Bold
        button.titleLabel?.textAlignment = .left
        button.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        return button
    }()
    
    
    let dueDate = DatePicker(frame: .zero, title: "Deadline")
    
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
    
    let total = TextField(frame: .zero, title: "Jumlah", style: .template, prefix: "Rp")
    
    let goalType = TextField(frame: .zero, title: "Tipe Goal", style: .template, icon: UIImage(systemName: "greaterthan"))
    
    let iconView = IconView()
    
    let switchView = SwitchView()
    
    let saveButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Simpan")
    
    //scrollView
    lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            return scrollView
        }()
    
    
    func configureStackView() {
        self.backgroundColor = .ghostWhite
        
        let vstack = UIStackView(arrangedSubviews: [iconView,
                                                    goalName,
                                                    recommendButton,
                                                    dueDate,
                                                    total,
                                                    inflationButton,
                                                    goalType,
                                                    switchView,
                                                   saveButton]
        )
        
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 16
        vstack.setCustomSpacing(8, after: goalName)
        vstack.setCustomSpacing(12, after: total)
        
        //autolayout
        self.addSubview(scrollView)

        scrollView.addSubview(vstack)
        
        scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width)

        vstack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingRight: 20)

        NSLayoutConstraint.activate([
            vstack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        
        //iconview
        iconView.setUp()
        iconView.heightAnchor.constraint(equalTo: iconView.iconLabel.heightAnchor).isActive = true
        
        //switchview
        switchView.setupView()
    }
}

class IconView: UIView {
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
    
    let editButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .tangerineYellow
        button.frame.size = CGSize(width: 10, height: 10)
        button.layer.cornerRadius = button.frame.height/2
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)
        let symbol = UIImage(systemName: "pencil", withConfiguration: config)
        button.setImage(symbol, for: .normal)
        return button
    }()
    
    func setUp() {
        //auto-layout
        
        addSubview(editButton)
        addSubview(iconLabel)
        bringSubviewToFront(editButton)
        
        editButton.anchor(bottom: iconLabel.bottomAnchor, right: iconLabel.rightAnchor, paddingRight: 20)
        
        iconLabel.centerX(inView: self)
        
        iconLabel.anchor(width: 150, height: 150)
    }

}

class SwitchView: UIView {
    
    let didHaveInitSaving: UILabel = {
        let label = UILabel()
        label.text = "Punya tabungan awal?"
        label.font = .bodyBold
        label.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        return label
    }()
    
    var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.setOn(false, animated: true)
        toggle.onTintColor = .royalHunterBlue
        return toggle
    }()
    
    let tf = TextField(frame: .zero, style: .template, prefix: "Rp")
    
    @objc func switchStateDidChange(_ sender:UISwitch!) {
        if (toggleSwitch.isOn == true){
//            makePrefix()
            tf.isHidden = false
        }
        else{
//            makePrefix()
            tf.isHidden = true
        }
    }
    
    func setupView() {
        addSubview(didHaveInitSaving)
        didHaveInitSaving.anchor(top: self.topAnchor, left: self.leftAnchor)
        
        addSubview(toggleSwitch)
        toggleSwitch.anchor(top: self.topAnchor, left: didHaveInitSaving.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 50)
        toggleSwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        
        addSubview(tf)
        tf.anchor(top: didHaveInitSaving.topAnchor, left: didHaveInitSaving.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 40, paddingBottom: 20)
        tf.isHidden = true
    }
    
}

