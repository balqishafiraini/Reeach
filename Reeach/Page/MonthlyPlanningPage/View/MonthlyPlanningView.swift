//
//  MonthlyPlanningView.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningView: UIView {
    
    var selectedDate: Date?
    var currentDateString: String?
    var selectedDateString: String?
    
    var delegate: PlannerDelegate?
    
    var incomeBudgets: [Budget] = []
    var goalBudgets: [Budget] = []
    var needBudgets: [Budget] = []
    var wantBudgets: [Budget] = []
    
    var hasBudget: Bool? = false
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Monthly Planner"
        label.font = .largeTitle
        label.textColor = .whiteSmoke
        label.textAlignment = .center
        
        return label
    }()
    
    // TODO: optimize backMonthButton & nextMonthButton
    lazy var backMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(.primary6, for: .normal)
        button.addTarget(self, action: #selector(setMonth), for: .touchUpInside)
        
        return button
    }()
    
    lazy var selectedMonthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primary6
        label.font = .headline
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.setTitleColor(.primary6, for: .normal)
        button.addTarget(self, action: #selector(setMonth), for: .touchUpInside)
        
        return button
    }()
    
    lazy var monthSelectorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(backMonthButton)
        stack.setCustomSpacing(12, after: backMonthButton)
        stack.addArrangedSubview(selectedMonthLabel)
        stack.setCustomSpacing(12, after: selectedMonthLabel)
        stack.addArrangedSubview(nextMonthButton)
        
        return stack
    }()
    
    lazy var noPlanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EmptyMonthlyPlan")
        
        return imageView
    }()
    
    lazy var noPlanLabel: UILabel = {
//        let view = UIView()
        
        let label = UILabel()
        label.text = "Kamu belum memiliki Monthly Planner bulan ini."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .bodyMedium
        label.textColor = .black
        
//        view.addSubview(label)
//
//        label.addConstraintsToFillView(view)
//
//        NSLayoutConstraint.activate([
//            label.widthAnchor.constraint(equalTo: view.widthAnchor)
//        ])
        
        return label
    }()
    
    lazy var createMonthlyPlanButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Buat Monthly Planner")
        button.addTarget(self, action: #selector(createMonthlyPlan), for: .touchUpInside)
        
        return button
    }()
    
    lazy var noPlanStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        
        stack.addArrangedSubview(noPlanImage)
        stack.setCustomSpacing(8, after: noPlanLabel)
        stack.addArrangedSubview(noPlanLabel)
        stack.setCustomSpacing(28, after: noPlanLabel)
        stack.addArrangedSubview(createMonthlyPlanButton)
        
        noPlanLabel.anchor(left: stack.leftAnchor, right: stack.rightAnchor)
        createMonthlyPlanButton.anchor(left: stack.leftAnchor, right: stack.rightAnchor)
        
        return stack
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = "Wah, kamu belum buat Monthly Planner nih. Yuk buat sekarang!"
        label.font = .headline
        label.textColor = .black13
        label.numberOfLines = 5
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var tipView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondary1 //TODO: Change background color to conform HiFi
        view.layer.cornerRadius = 16
        
        view.addSubview(tipLabel)
        tipLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var blankView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    
    lazy var incomeStack = BudgetView()
    lazy var goalStack = BudgetView()
    lazy var needStack = BudgetView()
    lazy var wantStack = BudgetView()
    
    lazy var tipViewConstraint = tipView.topAnchor.constraint(equalTo: monthSelectorStack.bottomAnchor, constant: 20)
    lazy var contentViewConstraint = contentView.topAnchor.constraint(equalTo: monthSelectorStack.bottomAnchor, constant: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.roundCorners([.topLeft, .topRight], radius: 28)
    }
    
    func setupDate(currentDate: Date) {
        self.selectedDate = DateFormatHelper.getStartDateOfMonth(of: currentDate)
        self.currentDateString = DateFormatHelper.getMonthAndYearString(from: currentDate)
        self.selectedDateString = DateFormatHelper.getMonthAndYearString(from: currentDate)
        
        selectedMonthLabel.text = DateFormatHelper.getMonthAndYearString(from: currentDate)
    }
    
    
    
    func setupAdditionalView() {
        if currentDateString == selectedDateString {
            nextMonthButton.setTitle("", for: .normal)
            nextMonthButton.isEnabled = false
            
            tipView.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
            tipView.centerYAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            
            tipView.isHidden = false
            contentViewConstraint.isActive = false
            
            contentView.addSubview(noPlanStack)
            noPlanStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 72, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
            noPlanImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 5/8).isActive = true
            noPlanImage.heightAnchor.constraint(equalTo: noPlanImage.widthAnchor).isActive = true
                        
            tipViewConstraint.isActive = true
            
            createMonthlyPlanButton.isHidden = false
            
            return
        }
        nextMonthButton.setTitle(">", for: .normal)
        nextMonthButton.isEnabled = true
        
        tipView.isHidden = true
        tipViewConstraint.isActive = false
        
        contentViewConstraint.isActive = true
        
        createMonthlyPlanButton.isHidden = true
    }
    
    func setupView() {
        if hasBudget! {
            print("Should setup view")
        } else {
            print("No budget")
        }
        
        self.backgroundColor = .secondary6
        
        self.addSubview(blankView)
        self.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(monthSelectorStack)
        containerView.addSubview(contentView)
        containerView.addSubview(tipView)
        
        contentView.addSubview(noPlanStack)
        contentView.addSubview(incomeStack)
        contentView.addSubview(goalStack)
        contentView.addSubview(needStack)
        contentView.addSubview(wantStack)
        
        configureAutoLayout()
        
        setupContentView()
    }
    
    func setupContentView() {
        if hasBudget! { // Punya budget
            noPlanStack.isHidden = true
            
            incomeStack = BudgetView(frame: CGRectZero, labelText: "Ringkasan Monthly Budget", type: "Income", disableButtonAndStatus: true)
            goalStack = BudgetView(frame: CGRectZero, labelText: "Goal", type: "Goal", disableButtonAndStatus: true)
            needStack = BudgetView(frame: CGRectZero, labelText: "Kebutuhan", type: "Need", disableButtonAndStatus: true)
            wantStack = BudgetView(frame: CGRectZero, labelText: "Keingingan", type: "Want", disableButtonAndStatus: true)
            
            incomeStack.budgets = incomeBudgets
            goalStack.budgets = goalBudgets
            needStack.budgets = needBudgets
            wantStack.budgets = wantBudgets
            
//            incomeStack.anchor(top: tipView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
//            goalStack.anchor(top: incomeStack.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
//            needStack.anchor(top: goalStack.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
//            wantStack.anchor(top: needStack.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
            
            incomeStack.setupView()
            goalStack.setupView()
            needStack.setupView()
            wantStack.setupView()
            
            if currentDateString == selectedDateString { // Di bulan yang sama
                // Tampilin budget dengan tipView
                nextMonthButton.setTitle("", for: .normal)
                nextMonthButton.isEnabled = false
                
                tipView.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
                tipView.centerYAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
                
                tipView.isHidden = false
                contentViewConstraint.isActive = false
                tipViewConstraint.isActive = true
                
                tipLabel.text = "Hooray! 🙌🏻 Monthly Bugdet kamu udah jadi. Jangan lupa untuk cek progresnya di Goals Tracker dan Cashflow Tracker secara rutin, ya!"
                                
            } else { // Di bulan yang beda
                // Tampilin budget tanpa tipView
                nextMonthButton.setTitle(">", for: .normal)
                nextMonthButton.isEnabled = true
                
                tipView.isHidden = true
                tipViewConstraint.isActive = false
                
                contentViewConstraint.isActive = true
            }
            
        } else { // Ngga punya budget
            noPlanStack.isHidden = false
            
            incomeStack.isHidden = true
            goalStack.isHidden = true
            needStack.isHidden = true
            wantStack.isHidden = true
            
            if currentDateString == selectedDateString {
                nextMonthButton.setTitle("", for: .normal)
                nextMonthButton.isEnabled = false
                
                tipView.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
                tipView.centerYAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
                
                tipView.isHidden = false
                contentViewConstraint.isActive = false
                
                tipLabel.text = "Wah, kamu belum buat Monthly Planner nih. Yuk buat sekarang!"
                noPlanLabel.text = "Kamu belum memiliki Monthly Planner di bulan ini."
                
                noPlanStack.isHidden = false
                noPlanStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 72, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
                noPlanImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 5/8).isActive = true
                noPlanImage.heightAnchor.constraint(equalTo: noPlanImage.widthAnchor).isActive = true
                            
                tipViewConstraint.isActive = true
                
                createMonthlyPlanButton.isHidden = false
            } else {
                nextMonthButton.setTitle(">", for: .normal)
                nextMonthButton.isEnabled = true
                
                tipView.isHidden = true
                tipViewConstraint.isActive = false
                
                noPlanLabel.text = "Kamu tidak memiliki Monthly Planner di bulan ini."
                
                contentViewConstraint.isActive = true

                createMonthlyPlanButton.isHidden = true
                
            }
        }
    }
    
    func configureAutoLayout() {
        blankView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 300)
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor)
        scrollView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        titleLabel.centerX(inView: scrollView)
        titleLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 20)
        monthSelectorStack.anchor(top: titleLabel.bottomAnchor)
        monthSelectorStack.centerX(inView: scrollView)
        
        contentView.anchor(left: scrollView.leftAnchor, bottom: containerView.bottomAnchor, right: scrollView.rightAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    @objc func setMonth(_ sender: UIButton) {
        print(#function)
        switch sender.currentTitle! {
        case "<":
            nextMonthButton.isHidden = false
            self.selectedDate = DateFormatHelper.getStartDateOfPreviousMonth(of: selectedDate ?? Date())
        case ">":
            if selectedDateString == currentDateString {
                return
            }
            self.selectedDate = DateFormatHelper.getStartDateOfNextMonth(of: selectedDate ?? Date())
        default:
            print("Something went wrong in \(#function)!")
        }
        
        self.selectedDateString = DateFormatHelper.getMonthAndYearString(from: selectedDate ?? Date())
        selectedMonthLabel.text = selectedDateString
        
        delegate?.getPlanner(forDate: selectedDate ?? Date())
    }
    
    @objc func createMonthlyPlan() {
        print(#function)
    }
    
}
