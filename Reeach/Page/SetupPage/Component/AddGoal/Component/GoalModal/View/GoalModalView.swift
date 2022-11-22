//
//  GoalModalView.swift
//  Reeach
//
//  Created by Balqis on 01/11/22.
//

import Foundation
import UIKit

class GoalModalView: UIView {
    weak var viewDelegate: GoalModalViewDelegate?
    weak var navigationBarDelegate: NavigationBarDelegate?
    weak var viewController: GoalModalViewController?
    
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
    
    
    lazy var dueDate = {
        let datePicker = DatePicker(frame: .zero, title: "Deadline")
        datePicker.datePicker.minimumDate = Date()
        return datePicker
    }()
    
    let inflationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.imageView?.heightAnchor.constraint(equalTo: button.titleLabel?.heightAnchor ?? button.heightAnchor).isActive = true
        button.imageView?.widthAnchor.constraint(equalTo: button.imageView!.heightAnchor).isActive = true
        button.tintColor = .royalHunterBlue
        button.setTitle("Nilai setelah inflasi: ", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        button.setTitleColor(.royalHunterBlue, for: .normal)
        button.titleLabel?.font = .caption1Bold
        button.titleLabel?.textAlignment = .left
        button.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        return button
    }()
    
    let total = TextField(frame: .zero, title: "Target Goal", style: .template, prefix: "Rp")
    
    let goalType = {
        let tf = TextField(frame: .zero, title: "Tipe Goal", style: .template, icon: UIImage(named: "ChevronRight"))
        tf.tintColor = .clear
        tf.textField.isUserInteractionEnabled = false
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
    
    func configureStackView(viewController: GoalModalViewController) {
        self.backgroundColor = .ghostWhite
        
        self.viewController = viewController
        viewDelegate = viewController
        navigationBarDelegate = viewController
        setupAddTargetIsNotEmptyTextFields()
        hideKeyboardWhenTappedAround()
        
        goalType.textField.delegate = self
        total.textField.delegate = self
        switchView.tf.textField.delegate = self
        iconView.iconTextField.delegate = self
        dueDate.textField.textField.delegate = self
        
        total.textField.keyboardType = .numberPad
        switchView.tf.textField.keyboardType = .numberPad
        
        goalType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToTermPicker)))
        recommendButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        inflationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveGoalToCoreData), for: .touchUpInside)
        iconView.editButton.addTarget(self, action: #selector(editIconTapped), for: .touchUpInside)
        
        setNavigationBar()
        
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
    
    func setNavigationBar() {
        let doneItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        doneItem.setTitleTextAttributes(attributes, for: .normal)
        
        viewController?.navigationItem.leftBarButtonItem = doneItem
    }
    
    @objc func editIconTapped(_ sender: UIButton!) {
        iconView.iconTextField.isUserInteractionEnabled = true
        iconView.iconTextField.becomeFirstResponder()
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        saveButton.isEnabled = false
        [goalName.textField, total.textField, iconView.iconTextField, switchView.tf.textField].forEach({ $0.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged) })
    }
    
    @objc func textFieldsIsNotEmpty(_ sender: UITextField) {
        viewDelegate?.updateInflationButton()
        
        let initialSavingDouble = Double(switchView.tf.textField.text?.replacingOccurrences(of: ".", with: "") ?? "0") ?? 0
        switchView.tf.textField.text = CurrencyHelper.getFormattedNumber(from: initialSavingDouble)
        
        let totalAmountDouble = Double(total.textField.text?.replacingOccurrences(of: ".", with: "") ?? "0") ?? 0
        total.textField.text = CurrencyHelper.getFormattedNumber(from: totalAmountDouble)
        
        guard
            let goalTitle = goalName.textField.text, !goalTitle.isEmpty,
            let totalAmount = total.textField.text, !totalAmount.isEmpty,
            let iconEmoji = iconView.iconTextField.text, !iconEmoji.isEmpty,
            let goalTerm = goalType.textField.text, !goalTerm.isEmpty,
            let goalDueDate = dueDate.textField.textField.text, !goalDueDate.isEmpty
        else {
            saveButton.backgroundColor = .black4
            saveButton.setTitleColor(UIColor.black7, for: .normal)
            saveButton.isEnabled = false
            return
        }
        saveButton.backgroundColor = .tangerineYellow
        saveButton.setTitleColor(UIColor.black13, for: .normal)
        saveButton.isEnabled = true
    }
    
    @objc func saveGoalToCoreData() {
        let icon = iconView.iconTextField.text ?? ""
        let name = goalName.textField.text ?? "No Name"
        let dueDate = dueDate.date ?? Date()
        let termExtended = goalType.textField.text ?? "Unknown-term"
        let term = String(termExtended[..<(termExtended.firstIndex(of: "-") ?? termExtended.endIndex)])
        let amount = Double(total.textField.text?.replacingOccurrences(of: ".", with: "") ?? "0.0") ?? 0
        let initSaving = switchView.toggleSwitch.isOn ?  Double(switchView.tf.textField.text?.replacingOccurrences(of: ".", with: "") ?? "0.0") ?? 0 : 0
        
        viewDelegate?.save(name: name, icon: icon, dueDate: dueDate, targetAmount: amount, timeTerm: term, initialSaving: initSaving)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        dismissKeyboard()
        if sender == recommendButton {
            viewDelegate?.goToGoalRecommendation()
        }
        else if sender == inflationButton {
            viewDelegate?.goToInflationDetail()
        }
    }
    
    @objc func goToTermPicker(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissKeyboard()
        viewDelegate?.goToTermPicker()
    }
    
    @objc func dismissView() {
        navigationBarDelegate?.cancel()
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
            button.setImage(UIImage(named: "EditCircle"), for: .normal)
            return button
        }()
        
        func setUp() {
            //auto-layout
            
            addSubview(editButton)
            addSubview(iconTextField)
            bringSubviewToFront(editButton)
            
            editButton.anchor(bottom: iconTextField.bottomAnchor, right: iconTextField.rightAnchor, paddingRight: 15)
            
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

