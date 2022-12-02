//
//  TransactionFilterView.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TransactionFilterView: UIView {
    
    weak var controller: TransactionFilterViewController?
    weak var delegate: FilterDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filter Transaksi"
        label.font = .title
        label.textColor = .black13
        
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        
        return button
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(closeButton)
        
        return stack
    }()
    
    lazy var startMonthPicker = {
        let datePicker = DatePicker(frame: .zero, title: "Periode Transaksi")
        datePicker.datePicker.minimumDate = Date()
        return datePicker
    }()
    
    lazy var endMonthPicker = {
        let datePicker = DatePicker(frame: .zero, title: "Sampai")
        datePicker.datePicker.minimumDate = Date()
        return datePicker
    }()
    
    lazy var transactionTypeSelector = {
        let tf = TextField(frame: .zero, title: "Jenis Transaksi", style: .template, icon: UIImage(named: "ChevronRight"))
        tf.tintColor = .clear
        tf.textField.isUserInteractionEnabled = false
        tf.textField.placeholder = "Pilih Jenis Transaksi"
        return tf
    }()
    
    lazy var categoryBudgetSelector = {
        let tf = TextField(frame: .zero, title: "Kategori Budget", style: .template, icon: UIImage(named: "ChevronRight"))
        tf.tintColor = .clear
        tf.textField.isUserInteractionEnabled = false
        tf.textField.placeholder = "Pilih Kategori Budget"
        return tf
    }()
    
    lazy var filterButton = Button(style: .rounded, title: "Lihat Hasil", textColor: .black13, backColor: .primary)
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        view.clipsToBounds = true
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .ghostWhite
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .ghostWhite
        
        contentStack.addArrangedSubview(startMonthPicker)
        contentStack.addArrangedSubview(endMonthPicker)
        contentStack.addArrangedSubview(transactionTypeSelector)
        contentStack.addArrangedSubview(categoryBudgetSelector)
        contentStack.addArrangedSubview(filterButton)
        
        containerView.addSubview(contentStack)
        
        scrollView.addSubview(containerView)
        
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentStack.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        setupButtonTarget()
    }
    
    func setupButtonTarget() {        
        let tapTypePicker = UITapGestureRecognizer(target: self, action: #selector(openTypePicker))
        let tapCategordyBudgetPicker = UITapGestureRecognizer(target: self, action: #selector(openCategoryBudgetPicker))
        
        transactionTypeSelector.addGestureRecognizer(tapTypePicker)
        categoryBudgetSelector.addGestureRecognizer(tapCategordyBudgetPicker)
        
        filterButton.addTarget(self, action: #selector(filterTransaction), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
    }
    
    @objc func filterTransaction() {
        dismissKeyboard()
        delegate?.filterTransaction()
    }
    
    @objc func openTypePicker(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissKeyboard()
        delegate?.openPicker(type: TypePickerViewController.identifier)
    }
    
    @objc func openCategoryBudgetPicker() {
        dismissKeyboard()
        delegate?.openPicker(type: "BudgetCategory")
    }
}
