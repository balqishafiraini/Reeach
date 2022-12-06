//
//  AddNewTransactionModalView.swift
//  Reeach
//
//  Created by James Christian Wira on 06/12/22.
//

import UIKit

class AddNewTransactionModalView: UIView {

    var transaction: Transaction?
    var budget: Budget?
    
    var income: Double = 0.0
    
    lazy var iconPicker = IconView()
    
    lazy var transactionName: TextField = {
        let textField = TextField(frame: .zero, title: "Nama Transaksi", style: .template)
        textField.textField.placeholder = "Kamu habis beli apa?"
        
        return textField
    }()

    lazy var transactionAmount: TextField = {
        let textField = TextField(frame: .zero, title: "Nominal Transaksi", style: .template, prefix: "Rp. ")
        textField.textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var transactionDate = DatePicker(frame: .zero, title: "Tanggal Transaksi")
    
    lazy var transactionBudgetCategory: TextField = {
        let textField = TextField(frame: .zero, title: "Kategori Budget", style: .template)
        textField.textField.placeholder = "Hayoo abis buat apa?"
        
        return textField
    }()

    lazy var formStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        if let budget = budget {
            transactionBudgetCategory.textField.text = budget.category?.name
            transactionBudgetCategory.textField.isEnabled = false
        }
        
        if let transaction = transaction {
            transactionName.textField.text = transaction.name
            transactionAmount.textField.text = CurrencyHelper.getFormattedNumber(from: transaction.amount)
            transactionDate.textField.textField.text = DateFormatHelper.getDDMMyyyy(from: transaction.date!)
            transactionBudgetCategory.textField.text = transaction.budget?.category?.name
        }
    }
    
    func setupView() {
        setupData()
        self.backgroundColor = .ghostWhite
        
        iconPicker.setUp()
        iconPicker.heightAnchor.constraint(equalTo: iconPicker.iconTextField.heightAnchor).isActive = true
        
        formStack.addArrangedSubview(iconPicker)
        formStack.addArrangedSubview(transactionName)
        formStack.addArrangedSubview(transactionAmount)
        formStack.addArrangedSubview(transactionDate)
        formStack.addArrangedSubview(transactionBudgetCategory)
        
        scrollView.addSubview(formStack)
        
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor)
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        formStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        formStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        setupTargets()
    }
    
    func setupTargets(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
        
        transactionAmount.textField.addTarget(self, action: #selector(updateTextField), for: .allEditingEvents)
        transactionAmount.textField.sendActions(for: .valueChanged)
        
        transactionDate.textField.textField.addTarget(self, action: #selector(updateDate), for: .allEditingEvents)
        transactionDate.textField.textField.sendActions(for: .valueChanged)
        
        transactionDate.textField.textField.placeholder = "DD/MM/YYYY"
        transactionDate.textField.textField.text = DateFormatHelper.getDDMMyyyy(from: transactionDate.date ?? Date())
        
        iconPicker.editButton.addTarget(self, action: #selector(editIconTapped), for: .touchUpInside)
    }
    
    @objc func editIconTapped(_ sender: UIButton!) {
        iconPicker.iconTextField.isUserInteractionEnabled = true
        iconPicker.iconTextField.becomeFirstResponder()
    }
    
    
    @objc func updateTextField() {
        let textField = transactionAmount.textField
        let incomeString = (textField.text ?? "0.0").replacingOccurrences(of: ".", with: "")
        let incomeDouble = Double(incomeString) ?? 0.0
        income = incomeDouble
        
        textField.text = CurrencyHelper.getFormattedNumber(from: incomeDouble)
    }
    
    @objc func updateDate() {
        print(#function)
        let textField = transactionDate.textField.textField
        textField.text = DateFormatHelper.getDDMMyyyy(from: transactionDate.date ?? Date())
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
}
