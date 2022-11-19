//
//  AddBudget.swift
//  Reeach
//
//  Created by James Christian Wira on 25/10/22.
//

import UIKit

class AddBudget: UIView {
    
    weak var delegate: SetupDelegate?
    weak var budgetDelegate: BudgetDelegate?
    
    var goalBudgets: [Budget]?
    var needBudgets: [Budget]?
    var wantBudgets: [Budget]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topTitle: UILabel = {
        let label = UILabel()
        label.text = "Budget"
        label.font = UIFont(name: "GeneralSans-Bold", size: 30)
        
        return label
    }()
    
    let viewDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Yuk, rencanakan keuanganmu supaya target goals terkumpul pakai metode 50/30/20."
        label.font = .bodyMedium
        label.numberOfLines = 5
        label.textColor = .black8
        
        return label
    }()
    
    let headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var goalStack = BudgetView()
    
    lazy var needStack = BudgetView()
    
    lazy var wantStack = BudgetView()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    let contentView = UIView()
    
    func setupContentStack() {
        goalStack = BudgetView(frame: CGRectZero, labelText: "Goal", type: "Goal")
        needStack = BudgetView(frame: CGRectZero, labelText: "Kebutuhan Pokok", type: "Need")
        wantStack = BudgetView(frame: CGRectZero, labelText: "Kebutuhan Nonpokok", type: "Want")
        
        goalStack.addButton.setTitle("Tambah budget untuk goals", for: .normal)
        needStack.addButton.setTitle("Tambah kebutuhan pokok", for: .normal)
        wantStack.addButton.setTitle("Tambah kebutuhan nonpokok", for: .normal)
        
        goalStack.delegate = self.delegate
        needStack.delegate = self.delegate
        wantStack.delegate = self.delegate
        
        goalStack.budgetDelegate = budgetDelegate
        needStack.budgetDelegate = budgetDelegate
        wantStack.budgetDelegate = budgetDelegate
        
        goalStack.budgets = goalBudgets!
        needStack.budgets = needBudgets!
        wantStack.budgets = wantBudgets!
        
        goalStack.setupView()
        needStack.setupView()
        wantStack.setupView()
    }
    
    func setupView() {
        setupContentStack()
        
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        headerStack.addArrangedSubview(goalStack)
        headerStack.addArrangedSubview(needStack)
        headerStack.addArrangedSubview(wantStack)
        
        contentView.addSubview(headerStack)
        
        headerStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingBottom: 20)
        headerStack.setCustomSpacing(12, after: topTitle)
        
        scrollView.addSubview(contentView)
        
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.maxX)
        
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
    }

    @objc func prevStep() {
        delegate?.previousProgress!()
    }
}
