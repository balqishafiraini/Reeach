//
//  GoalItemCollectionViewCell.swift
//  Reeach
//
//  Created by James Christian Wira on 15/11/22.
//

import UIKit

class GoalItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "goalItem"
    
    var iconName: String?
    var title: String?
    var dueDate: Date?
    var amount: Double?
    
    let size = 60.0
    
    lazy var iconLabel: UILabel = {
        let iv = UILabel()
        iv.font = UIFont.systemFont(ofSize: 32)
        
        return iv
    }()
    
    lazy var iconContainer: UIView = {
        let view = UIView()
        if #available(iOS 15, *){
            view.setDimensions(width: size, height: size)
        }
        view.layer.cornerRadius = size / 2
        view.backgroundColor = .secondary2
        
        view.addSubview(iconLabel)
        iconLabel.center(inView: view)
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .black13
        
        return label
    }()
    
    lazy var dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1Bold
        label.textColor = .secondary7
        
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMedium
        label.textColor = .black13
        label.text = CurrencyHelper.getCurrency(from: amount ?? 0.0)
        
        return label
    }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dueDateLabel)
        stack.addArrangedSubview(amountLabel)
        
        
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
        
        view.backgroundColor = .black4
        view.addSubview(iconContainer)
        view.addSubview(vStack)
        view.layer.cornerRadius = 16
        
        iconContainer.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: vStack.leftAnchor , paddingTop: 12, paddingLeft: 16, paddingBottom: 12, paddingRight: 16)
        vStack.anchor(top: view.topAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingBottom: 12, paddingRight: 16)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData() {
        iconLabel.text = iconName ?? "❓"
        titleLabel.text = title ?? "Goal title"
        dueDateLabel.text = DateFormatHelper.getShortMonthAndYearString(from: dueDate ?? Date())
        amountLabel.text = CurrencyHelper.getCurrency(from: amount ?? 0.0)
    }
    
    func configureView() {
        configureData()
        
        self.addSubview(container)
        
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        container.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 16, width: UIScreen.main.bounds.width - 32)
    }
}
