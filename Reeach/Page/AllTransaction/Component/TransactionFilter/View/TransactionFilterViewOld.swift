//
//  TransactionFilterView.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TransactionFilterViewOld: UIView {

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
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    let defaultHeight: CGFloat = 500
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    var currentContainerHeight: CGFloat = 500
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.roundCorners([.topLeft, .topRight], radius: 28)
    }
    
    func setupView() {
        self.backgroundColor = .clear
        
        contentStack.addArrangedSubview(headerStack)
        contentStack.addArrangedSubview(startMonthPicker)
        contentStack.addArrangedSubview(endMonthPicker)
        contentStack.addArrangedSubview(transactionTypeSelector)
        contentStack.addArrangedSubview(categoryBudgetSelector)
        contentStack.addArrangedSubview(filterButton)
        
        containerView.addSubview(contentStack)
        
        self.addSubview(dimmedView)
        self.addSubview(containerView)
        
        dimmedView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        containerView.anchor(left: self.leftAnchor, right: self.rightAnchor)
        
        contentStack.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 32, paddingLeft: 20, paddingBottom: 40, paddingRight: 20)
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        setupButtonTarget()
    }
    
    
    func setupButtonTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        let tapTypePicker = UITapGestureRecognizer(target: self, action: #selector(openTypePicker))
        let tapCategordyBudgetPicker = UITapGestureRecognizer(target: self, action: #selector(openCategoryBudgetPicker))
        
        closeButton.addTarget(self, action: #selector(handleCloseAction), for: .touchUpInside)
        
        transactionTypeSelector.addGestureRecognizer(tapTypePicker)
        categoryBudgetSelector.addGestureRecognizer(tapCategordyBudgetPicker)
    }
    
    @objc func handleCloseAction(_ gestureRecognizer: UITapGestureRecognizer) {
        animateDismissView()
    }
    
    @objc func openTypePicker(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissKeyboard()
        delegate?.openPicker(type: TypePickerViewController.identifier)
    }
    
    @objc func openCategoryBudgetPicker() {
        dismissKeyboard()
        delegate?.openPicker(type: "BudgetCategory")
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.controller!.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.controller!.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.controller!.dismiss(animated: false)
        }
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.controller!.view.layoutIfNeeded()
        }
    }
}
