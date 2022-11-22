//
//  AddBudget.swift
//  Reeach
//
//  Created by James Christian Wira on 25/10/22.
//

import UIKit

class AddBudget: UIView {
    
    weak var delegate: SetupPageViewController?
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
    
    lazy var explanationButton: UILabel = {
        let buttonLabel = UILabel()
        
        buttonLabel.text = "Baca detilnya di sini."
        buttonLabel.textColor = .secondary6
        buttonLabel.font = .bodyBold
        buttonLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showExplanation))
        buttonLabel.addGestureRecognizer(tap)
        
        return buttonLabel
    }()
    
    lazy var allocationBar: AllocationBar = {
        let bar = AllocationBar()
        bar.configureView()
        
        return bar
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
        self.backgroundColor = .ghostWhite
        setupContentStack()
        
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        headerStack.addArrangedSubview(explanationButton)
        headerStack.addArrangedSubview(allocationBar)
        headerStack.addArrangedSubview(goalStack)
        headerStack.addArrangedSubview(needStack)
        headerStack.addArrangedSubview(wantStack)
        
        contentView.addSubview(headerStack)
        
        headerStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingBottom: 20)
        headerStack.setCustomSpacing(12, after: topTitle)
        headerStack.setCustomSpacing(0, after: viewDescription)
        
        scrollView.addSubview(contentView)
        
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.maxX)
        
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        setAllocationBar()
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
    }
    
    func setAllocationBar() {
        let incomeCategory = DatabaseHelper().getCategory(name: "Income")
        let incomeBudget = DatabaseHelper().getBudget(on: Date(), of: incomeCategory!)
        let income = incomeBudget?.monthlyAllocation ?? 0.0
        
        var goal = 0.0
        var need = 0.0
        var want = 0.0
        
        for budget in goalBudgets! {
            goal += budget.monthlyAllocation
        }
        
        for budget in needBudgets! {
            need += budget.monthlyAllocation
        }
        
        for budget in wantBudgets! {
            want += budget.monthlyAllocation
        }

        allocationBar.adjustWidth(goal: goal, need: need, want: want, income: income)
    }
    
    @objc func showExplanation() {
        budgetDelegate?.showTip()
    }

    @objc func prevStep() {
        delegate?.previousProgress()
    }
}
