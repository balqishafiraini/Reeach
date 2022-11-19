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
    lazy var backButton = UIImage(named: "LeftYellow")
    lazy var nextButton = UIImage(named: "RightYellow")
    
    lazy var backMonthButton: UIButton = {
        let button = UIButton()
//        button.setTitle("<", for: .normal)
        button.setImage(backButton, for: .normal)
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
//        button.setTitle(">", for: .normal)
        button.setImage(nextButton, for: .normal)
        button.setTitleColor(.primary6, for: .normal)
        button.addTarget(self, action: #selector(setMonth), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        
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
        view.backgroundColor = .secondary1
        view.layer.cornerRadius = 16
        
        view.addSubview(tipLabel)
        tipLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
//        sv.backgroundColor = .secondary6
        
        return sv
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondary6
        
        return view
    }()
    
    lazy var blankView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondary6
        
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .ghostWhite
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var tipViewContainerView = UIView()
    lazy var monthStackContainerView = UIView()
    lazy var blankView2 = UIView()
    
    lazy var incomeStack = BudgetView()
    lazy var goalStack = BudgetView()
    lazy var needStack = BudgetView()
    lazy var wantStack = BudgetView()
    
    lazy var contentTopToTip = tipView.topAnchor.constraint(equalTo: monthSelectorStack.bottomAnchor, constant: 20)
    
    lazy var contentToSelector = contentView.topAnchor.constraint(equalTo: monthSelectorStack.bottomAnchor, constant: 20)
    
    lazy var stackTopToTip = contentStack.topAnchor.constraint(equalTo: tipView.bottomAnchor, constant: 24)
    
    lazy var stackToContent = contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
    
    lazy var contentStackWithPaddingTop = contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32)
    
    lazy var contentStackWithoutPaddingTop = contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blankView.roundCorners([.topLeft, .topRight], radius: 28)
        contentView.roundCorners([.topLeft, .topRight], radius: shouldSetValue(value: 28))
    }
    
    func setupDate(currentDate: Date) {
        self.selectedDate = DateFormatHelper.getStartDateOfMonth(of: currentDate)
        self.currentDateString = DateFormatHelper.getMonthAndYearString(from: currentDate)
        self.selectedDateString = DateFormatHelper.getMonthAndYearString(from: currentDate)
        
        selectedMonthLabel.text = DateFormatHelper.getMonthAndYearString(from: currentDate)
    }
    
    func shouldSetValue(value: CGFloat) -> CGFloat {
        if hasBudget! {
            if selectedDateString == currentDateString {
                return 0
            } else {
                return value
            }
        }
        
        return value
    }
    
    func setupView() {
        self.backgroundColor = .secondary6
        configureStacks()
        
        monthStackContainerView.addSubview(monthSelectorStack)
        monthSelectorStack.anchor(top: monthStackContainerView.topAnchor, bottom: monthStackContainerView.bottomAnchor)
        monthSelectorStack.centerX(inView: monthStackContainerView)
        
        tipViewContainerView.addSubview(blankView)
        tipViewContainerView.addSubview(tipView)
        
        contentStack.addArrangedSubview(incomeStack)
        contentStack.addArrangedSubview(goalStack)
        contentStack.addArrangedSubview(needStack)
        contentStack.addArrangedSubview(wantStack)
        contentStack.addArrangedSubview(noPlanStack)
        
        contentView.addSubview(contentStack)
        contentView.backgroundColor = .ghostWhite
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(monthStackContainerView)
        stack.addArrangedSubview(tipViewContainerView)
        stack.addArrangedSubview(contentView)
        
        stack.setCustomSpacing(10, after: monthStackContainerView)
    
        scrollView.addSubview(stack)
        
        self.addSubview(blankView2)
        self.addSubview(scrollView)
        
        stack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, paddingTop: 8)
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor, width: UIScreen.main.bounds.maxX)
        
        contentStack.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 16, paddingBottom: 20, paddingRight: 16)
    
        tipView.anchor(top: tipViewContainerView.topAnchor, left: tipViewContainerView.leftAnchor, bottom: tipViewContainerView.bottomAnchor, right: tipViewContainerView.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        blankView.anchor(top: tipView.centerYAnchor, left: tipViewContainerView.leftAnchor, bottom: tipViewContainerView.bottomAnchor, right: tipViewContainerView.rightAnchor)
        blankView.backgroundColor = .ghostWhite
        
        blankView2.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor, paddingTop: 300)
        blankView2.backgroundColor = .ghostWhite
        
        
        tipViewContainerView.isHidden = !hasBudget!
        tipLabel.text = hasBudget! ? "Hooray! 🙌🏻 Monthly Bugdet kamu udah jadi. Jangan lupa untuk cek progresnya di Goals Tracker dan Cashflow Tracker secara rutin, ya!" : "Wah, kamu belum buat Monthly Planner nih. Yuk buat sekarang!"
        
        noPlanStack.isHidden = hasBudget!
        incomeStack.isHidden = !hasBudget!
        needStack.isHidden = !hasBudget!
        goalStack.isHidden = !hasBudget!
        wantStack.isHidden = !hasBudget!
        
        if selectedDateString == currentDateString {
            contentStackWithPaddingTop.isActive = false
            contentStackWithoutPaddingTop.isActive = true
        } else {
            contentStackWithoutPaddingTop.isActive = false
            contentStackWithPaddingTop.isActive = true
        }
            
        if hasBudget! {
            if selectedDateString == currentDateString {
                nextMonthButton.isEnabled = false

            } else {
                nextMonthButton.isEnabled = true
                
                tipViewContainerView.isHidden = true
            }
        } else {
            if selectedDateString == currentDateString {
                nextMonthButton.isEnabled = false
                
                createMonthlyPlanButton.isHidden = false
                
                noPlanLabel.text = "Kamu belum memiliki Monthly Planner bulan ini."
            } else {
                nextMonthButton.isEnabled = true
                
                createMonthlyPlanButton.isHidden = true
                
                noPlanLabel.text = "Kamu tidak memiliki Monthly Planner di bulan ini."
            }
        }
    }
    
    func configureStacks() {
        incomeStack = BudgetView(frame: .zero, labelText: "Ringkasan Monthly Budget", type: "Income", disableButtonAndStatus: true)
        goalStack = BudgetView(frame: .zero, labelText: "Goal", type: "Goal", disableButtonAndStatus: true)
        needStack = BudgetView(frame: .zero, labelText: "Kebutuhan", type: "Need", disableButtonAndStatus: true)
        wantStack = BudgetView(frame: .zero, labelText: "Keingingan", type: "Want", disableButtonAndStatus: true)
        
        incomeStack.budgets = incomeBudgets
        goalStack.budgets = goalBudgets
        needStack.budgets = needBudgets
        wantStack.budgets = wantBudgets
        
        incomeStack.setupView()
        goalStack.setupView()
        needStack.setupView()
        wantStack.setupView()
    }
    
    func removeStacks() {
        incomeStack.removeFromSuperview()
        goalStack.removeFromSuperview()
        needStack.removeFromSuperview()
        wantStack.removeFromSuperview()
    }
    
    @objc func setMonth(_ sender: UIButton) {
        switch sender.currentImage {
        case backButton:
            removeStacks()
            nextMonthButton.isHidden = false
            self.selectedDate = DateFormatHelper.getStartDateOfPreviousMonth(of: selectedDate ?? Date())
        case nextButton:
            removeStacks()
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
