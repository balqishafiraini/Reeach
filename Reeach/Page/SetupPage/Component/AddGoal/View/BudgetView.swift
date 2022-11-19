//
//  BudgetView.swift
//  Reeach
//
//  Created by James Christian Wira on 07/11/22.
//

import UIKit

class BudgetView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var labelText: String
    var type: String // Goal, Need, Want
    var budgets: [Budget]?
    var allocated: Double = 0.0
    var allocationCount = 0
    var shouldDisableButton: Bool
    
    weak var delegate: SetupDelegate?
    
    init(frame: CGRect, labelText: String, type: String, disableButtonAndStatus: Bool? = false){
        self.labelText = labelText
        self.type = type
        self.shouldDisableButton = disableButtonAndStatus!
        
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        self.labelText = "Implement label here"
        self.type = "Type"
        self.shouldDisableButton = false
        
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = .bodyBold
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
            
        label.textColor = .accentGreen7
        label.font = .caption1Bold
        
        return label
    }()
    
    lazy var budgetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var addButton: Button = {
        let button = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        
        return stack
    }()
    
    func setupView() {
        allocated = 0.0
        label.text = labelText
        
        self.addSubview(stack)
        
        for budget in budgets! {
            let newItem = BudgetItem(frame: .zero, icon: budget.category?.icon ?? "❓", title: budget.category?.name ?? "Title", amount: budget.monthlyAllocation)
            budgetStack.addArrangedSubview(newItem)
            allocationCount+=1
            
            allocated += budget.monthlyAllocation
        }
        
        setupStatusLabel()
        
        stack.addArrangedSubview(label)
        if !shouldDisableButton {
            stack.addArrangedSubview(statusLabel)
        }
        stack.addArrangedSubview(budgetStack)
        if !shouldDisableButton {
            stack.addArrangedSubview(addButton)
        }
        
        stack.setCustomSpacing(shouldDisableButton ? 12 : 4, after: label)
        stack.setCustomSpacing(12, after: statusLabel)
        stack.setCustomSpacing(12, after: budgetStack)
        
        stack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        addButton.addTarget(self, action: #selector(openGoalSelection), for: .touchUpInside)
    }
    
    func setupStatusLabel(){
        let hasBudget = !(budgets?.isEmpty ?? false)
        
        if hasBudget {
            statusLabel.isHidden = false
            stack.setCustomSpacing(4, after: label)
            
            getStatusLabelAndButton()
            
        } else {
            statusLabel.isHidden = true
            stack.setCustomSpacing(0, after: label)
        }
    }
    
    func getStatusLabelAndButton() {
        let incomeCategory = DatabaseHelper().getCategory(name: "Income")
        let incomeBudget = DatabaseHelper().getBudget(on: Date(), of: incomeCategory!)
        let income = incomeBudget?.monthlyAllocation ?? 0.0
        
        var target = 0.0
        var percentage = ""
        
        switch type {
        case "Goal":
            print("Get status label if Goal")
            target = income * 0.2
            percentage = "20%"
            
            if allocationCount == budgets?.count {
                addButton.isHidden = true
            } else {
                addButton.isHidden = false
            }
            
        case "Need":
            print("Get status label if Need")
            target = income * 0.5
            percentage = "50%"
        case "Want":
            print("Get status label if Want")
            target = income * 0.3
            percentage = "30%"
        default :
            print("Something when wrong in \(#function)")
        }
        
        statusLabel.textColor = .accentGreen7
        if allocated < target {
            statusLabel.text = "WADUH! Alokasi ini udah belum mencapai \(percentage)"
            statusLabel.textColor = .red7
        } else if allocated == target {
            statusLabel.text = "COOL! Alokasi ini udah mencapai \(percentage)"
//            addButton.isHidden = true
        } else {
            statusLabel.text = "COOL! Alokasi ini udah mencapai lebih dari \(percentage)"
//            addButton.isHidden = true
        }
    }
    
    @objc func openGoalSelection() {
        // TODO: Coba tambahin goal ke controller disini
//        print("\(#function) for \(type)")
    }
}
