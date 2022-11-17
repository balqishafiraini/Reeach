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
    
    lazy var noPlanLabel: UIView = {
        let view = UIView()
        
        let label = UILabel()
        label.text = "Kamu belum memiliki Monthly Planner bulan ini."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .bodyMedium
        label.textColor = .black
        
        view.addSubview(label)
        
        label.addConstraintsToFillView(view)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
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
        
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var tipView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondary1 //TODO: Change background color to conform HiFi
        view.layer.cornerRadius = 16
        
        let label = UILabel()
        label.text = "Wah, kamu belum buat Monthly Planner nih. Yuk buat sekarang!"
        label.font = .headline
        label.textColor = .black13
        label.numberOfLines = 5
        label.textAlignment = .center
        
        view.addSubview(label)
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
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
    
    lazy var tipViewConstraint = tipView.topAnchor.constraint(equalTo: monthSelectorStack.bottomAnchor, constant: 20)
    lazy var contentViewConstraint = contentView.topAnchor.constraint(equalTo: monthSelectorStack.bottomAnchor, constant: 20)
    
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
        self.backgroundColor = .secondary6
        
        self.addSubview(blankView)
        self.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(monthSelectorStack)
        containerView.addSubview(contentView)
        containerView.addSubview(tipView)
        
        configureAutoLayout()
        
        setupAdditionalView()
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
        
        setupAdditionalView()
    }
    
    @objc func createMonthlyPlan() {
        print(#function)
    }
    
}
