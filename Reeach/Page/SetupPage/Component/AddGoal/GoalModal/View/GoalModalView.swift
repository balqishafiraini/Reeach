//
//  GoalModalView.swift
//  Reeach
//
//  Created by Balqis on 01/11/22.
//

import Foundation
import UIKit

class GoalModalView: UIView {
    
    weak var delegate: GoalSetupDelegate?
    
    let goalName = {
        let tf = TextField(frame: .zero, title: "Judul Goal", style: .template)
        tf.textField.placeholder = "Tulis goals kamu di sini, bestie."
        return tf
        
    }()
    
    let recommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lihat rekomendasinya di sini!", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .secondary1
        button.setTitleColor(.secondary8, for: .normal)
        button.titleLabel?.font = .bodyBold
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 16
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
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
    
    let goalType = {
        let tf = TextField(frame: .zero, title: "Tipe Goal", style: .template, icon: UIImage(named: "ChevronRight"))
        tf.tintColor = .clear
        tf.textField.placeholder = "Pilih Tipe Goal"
        return tf
    }()
    
    let iconView = IconView()
    
    let switchView = SwitchView()
    
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
        
        iconView.setUp()
        iconView.heightAnchor.constraint(equalTo: iconView.iconTextField.heightAnchor).isActive = true
        
        switchView.setupView()
    }
    
    class IconView: UIView {
        let iconTextField: UIEmojiTextField = {
            let tf = UIEmojiTextField()
            tf.font = UIFont.systemFont(ofSize: 80)
            tf.attributedPlaceholder = NSAttributedString(string:"Tambah Icon", attributes:[NSAttributedString.Key.font :UIFont.bodyMedium!, NSAttributedString.Key.foregroundColor:UIColor.royalHunterBlue!])
            tf.textAlignment = .center
            tf.tintColor = .clear
            tf.backgroundColor = .secondary2
            tf.layer.cornerRadius = 75
            tf.layer.masksToBounds = true
            tf.isUserInteractionEnabled = false
            return tf
        }()
        
        let editButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .tangerineYellow
            button.tintColor = .royalHunterBlue
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            button.layer.cornerRadius = 25
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)
            let symbol = UIImage(systemName: "pencil", withConfiguration: config)
            button.setImage(symbol, for: .normal)
            return button
        }()
        
        func setUp() {
            //auto-layout
            
            addSubview(editButton)
            addSubview(iconTextField)
            bringSubviewToFront(editButton)
            
            editButton.anchor(bottom: iconTextField.bottomAnchor, right: iconTextField.rightAnchor, paddingRight: 8)
            
            iconTextField.centerX(inView: self)
            
            iconTextField.anchor(width: 150, height: 150)
        }
        
    }
    
    class SwitchView: UIView {
        
        let initSavingLabel: UILabel = {
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
            addSubview(initSavingLabel)
            initSavingLabel.anchor(top: self.topAnchor, left: self.leftAnchor)
            
            addSubview(toggleSwitch)
            toggleSwitch.anchor(top: self.topAnchor, left: initSavingLabel.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 50)
            toggleSwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
            
            addSubview(tf)
            tf.anchor(top: initSavingLabel.topAnchor, left: initSavingLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 40, paddingBottom: 20)
            tf.isHidden = true
        }
        
    }
    
}

