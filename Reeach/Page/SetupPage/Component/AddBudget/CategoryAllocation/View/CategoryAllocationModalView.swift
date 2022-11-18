//
//  GoalAllocationView.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class CategoryAllocationModalView: UIView {
    weak var viewDelegate: CategoryAllocationModalViewDelegate?
    weak var navigationBarDelegate: NavigationBarDelegate?
    weak var viewController: CategoryAllocationModalViewController?
    
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
    
    lazy var remainingLabel = {
        let label = UILabel()
        label.text = "Sisa anggaran: "
        label.font = .caption1Medium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    func configureStackView(viewController: CategoryAllocationModalViewController) {
        self.backgroundColor = .ghostWhite
        
        self.viewController = viewController
        viewDelegate = viewController
        navigationBarDelegate = viewController
        setupAddTargetIsNotEmptyTextFields()
        hideKeyboardWhenTappedAround()
        
        category.textField.delegate = self
        monthlyAllocation.textField.delegate = self
        monthlyAllocation.textField.keyboardType = .numberPad
        
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteBudget), for: .touchUpInside)
        
        setNavigationBar()
        
        let vstack = UIStackView(arrangedSubviews: [iconWithoutEdit, category, monthlyAllocation, remainingLabel])
        vstack.frame = self.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 16
        vstack.setCustomSpacing(8, after: monthlyAllocation)
        
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
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: -20)
        ])

        iconWithoutEdit.setUp()
        iconWithoutEdit.anchor(top: vstack.topAnchor, paddingTop: 20)
        iconWithoutEdit.heightAnchor.constraint(equalTo: iconWithoutEdit.iconLabel.heightAnchor).isActive = true
        
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
    
    func setupAddTargetIsNotEmptyTextFields() {
        saveButton.isEnabled = false
        monthlyAllocation.textField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(_ sender: UITextField) {
        viewDelegate?.updateRemainingLabel()
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard let category = category.textField.text, !category.isEmpty,
              let allocationAmount = monthlyAllocation.textField.text, !allocationAmount.isEmpty
        else {
            saveButton.backgroundColor = .black4
            saveButton.setTitleColor(UIColor.black7, for: .normal)
            saveButton.isEnabled = false
            return
        }
        
        guard let monthlyAllocation = Double(allocationAmount)
        else {
            saveButton.backgroundColor = .black4
            saveButton.setTitleColor(UIColor.black7, for: .normal)
            saveButton.isEnabled = false
            return
        }
        
        if monthlyAllocation <= 0 || monthlyAllocation > viewController?.maximumAllocation ?? 0 {
            saveButton.backgroundColor = .black4
            saveButton.setTitleColor(UIColor.black7, for: .normal)
            saveButton.isEnabled = false
            return
        }
        
        saveButton.backgroundColor = .tangerineYellow
        saveButton.setTitleColor(UIColor.black13, for: .normal)
        saveButton.isEnabled = true
    }
    
    @objc func dismissView() {
        navigationBarDelegate?.cancel()
    }
    
    @objc func save (_ sender: UIButton) {
        let monthlyAllocation = Double(monthlyAllocation.textField.text ?? "0.0") ?? 0
        viewDelegate?.save(monthlyAllocation: monthlyAllocation)
    }
    
    @objc func deleteBudget(_ sender: UIButton) {
        viewDelegate?.delete()
    }
}
