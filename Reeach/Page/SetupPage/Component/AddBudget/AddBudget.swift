//
//  AddBudget.swift
//  Reeach
//
//  Created by James Christian Wira on 25/10/22.
//

import UIKit

class AddBudget: UIView {
    
    weak var delegate: SetupDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
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
        
        label.text = "Sekarang, mari kita rencanakan anggaran perbulan mu. Kami merekomendasikan supaya teknik 50-30-20. Pelajari lebih lanjut"
        label.font = .bodyMedium
        label.numberOfLines = 5
        
        return label
    }()
    
    let headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var goalStack = BudgetView(frame: CGRectZero, labelText: "Goal", type: "Goal")
    
    lazy var needStack = BudgetView(frame: CGRectZero, labelText: "Kebutuhan", type: "Need")
    
    lazy var wantStack = BudgetView(frame: CGRectZero, labelText: "Keingingan", type: "Want")
    
    let backButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangelo, title: "Kembali ke income")
        
        return button
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    let contentView = UIView()
    
    private func setupView() {
        goalStack.delegate = self.delegate
        needStack.delegate = self.delegate
        wantStack.delegate = self.delegate
        
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        headerStack.addArrangedSubview(goalStack)
        headerStack.addArrangedSubview(needStack)
        headerStack.addArrangedSubview(wantStack)
        
        contentView.addSubview(headerStack)
        contentView.addSubview(backButton)
        
        headerStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: backButton.topAnchor, right: contentView.rightAnchor, paddingBottom: 44)
        backButton.anchor(top: headerStack.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 44)
        
        scrollView.addSubview(contentView)
        
        self.addSubview(scrollView)
        
        backButton.addTarget(self, action: #selector(prevStep), for: .touchUpInside)
        
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
