//
//  MonthlyPlanningView.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = "Wah, kamu belum buat Monthly Planner nih. Yuk buat sekarang!"
        label.font = .headline
        label.textColor = UIColor(named: "black13")
        label.numberOfLines = 2
        
        view.addSubview(label)
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
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
    
    func setupView() {
        self.backgroundColor = UIColor(named: "secondary6")
        
        scrollView.addSubview(noPlanStack)
//        contentView.addSubview(tipView)
        contentView.addSubview(scrollView)
        
        self.addSubview(contentView)
        
//        tipView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.topAnchor, right: contentView.rightAnchor)
//
        noPlanStack.center(inView: scrollView)
        NSLayoutConstraint.activate([
            noPlanStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        scrollView.addConstraintsToFillView(contentView)

        contentView.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.roundCorners([.topLeft, .topRight], radius: 28)
    }
}
