//
//  MonthlyPlanningView.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningView: UIView {
    
    // Adding comment for PR purpose
    // For demo purpose, probably will be deleted
    enum Month: CaseIterable {
        case Januari, Feburari, Maret, April, Mei, Juni, Juli, Agustus, September, Oktober, November, Desember
        
        mutating func next() {
            let allCases = type(of: self).allCases
            self = allCases[((allCases.firstIndex(of: self)! + 1) < 0 ? 0 : (allCases.firstIndex(of: self)! + 1)) % allCases.count]
        }
        
        mutating func prev() {
            let allCases = type(of: self).allCases
            self = allCases[((allCases.firstIndex(of: self)! - 1) < 0 ? 11 : (allCases.firstIndex(of: self)! - 1)) % allCases.count]
        }
    }
    
    var currentMonth: Month = .November
    
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
        label.text = "\(currentMonth.self) 2022"
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
    
    func setupView() {
        self.backgroundColor = .secondary6
        
        scrollView.addSubview(noPlanStack)
        contentView.addSubview(scrollView)
        
        self.addSubview(titleLabel)
        self.addSubview(monthSelectorStack)
        self.addSubview(contentView)
        self.addSubview(tipView)
        
        titleLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 16)
        monthSelectorStack.anchor(top: titleLabel.bottomAnchor)
        monthSelectorStack.centerX(inView: self)
        
        tipView.anchor(top: contentView.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: -32, paddingLeft: 16, paddingRight: 16)
        
        noPlanStack.center(inView: scrollView)
        NSLayoutConstraint.activate([
            noPlanStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        scrollView.addConstraintsToFillView(contentView)

        contentView.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
        
    }
    
    @objc func setMonth(_ sender: UIButton) {
        switch sender.currentTitle! {
        case "<":
            currentMonth.prev()
            selectedMonthLabel.text = "\(currentMonth) 2022"
        case ">":
            currentMonth.next()
            selectedMonthLabel.text = "\(currentMonth) 2022"
        default:
            print("Wtf u want?")
        }
    }
    
    @objc func createMonthlyPlan() {
        print(#function)
    }
}
