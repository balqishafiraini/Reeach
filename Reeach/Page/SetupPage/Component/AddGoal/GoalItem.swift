//
//  GoalItem.swift
//  Reeach
//
//  Created by James Christian Wira on 11/11/22.
//

import UIKit

class GoalItem: UIView {
    let size = 60.0
    
    lazy var icon: UIImageView = {
        let iv = UIImageView()
//        iv.setDimensions(width: size, height: size)
//        iv.backgroundColor = UIColor(named: "secondary2")
        
        return iv
    }()
    
    lazy var iconContainer: UIView = {
        let view = UIView()
        view.setDimensions(width: size, height: size)
        view.layer.cornerRadius = size / 2
        view.backgroundColor = UIColor(named: "secondary2")
        
        view.addSubview(icon)
        icon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = UIColor(named: "secondary7")
        
        return label
    }()
    
    lazy var dueDate: UILabel = {
        let label = UILabel()
        label.font = .caption1Bold
        label.textColor = UIColor(named: "secondary7")
        
        return label
    }()
    
    lazy var amount: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        label.textColor = UIColor(named: "neutral13")
        
        return label
    }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(dueDate)
        stack.addArrangedSubview(amount)
        
        
        return stack
    }()
    
    lazy var summaryView: UIView = {
        let view = UIView()
        view.addSubview(vStack)
        
        vStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 12, paddingRight: 12)
        
        return view
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "neutral4")
        view.addSubview(iconContainer)
        view.addSubview(vStack)
        view.layer.cornerRadius = 16
        
        iconContainer.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: vStack.leftAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 12, paddingRight: 16)
        vStack.anchor(top: view.topAnchor, left: iconContainer.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 12, paddingRight: 16)
        
        return view
    }()
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(editGoal))
    
    init(frame: CGRect, iconName: String, title: String, dueDate: Date, amount: Double) {
        super.init(frame: frame)
        
        self.icon.image = UIImage(systemName: iconName)
        self.icon.tintColor = .black
        self.title.text = title
        if #available(iOS 15.0, *) {
            self.dueDate.text = dueDate.formatted(date: .abbreviated, time: .omitted)
        } else {
            // Fallback on earlier versions
            self.dueDate.text = dueDate.description
        }
        self.amount.text = CurrencyHelper.getCurrency(from: amount)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(container)
        self.addGestureRecognizer(tap)

        container.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    @objc func editGoal() {
        print("This will open sheet to edit the goal")
    }
}
