//
//  AllocationBar.swift
//  Reeach
//
//  Created by William Chrisandy on 19/11/22.
//

import UIKit

class AllocationBar: UIView {
    private lazy var rootStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var percentageStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var goalPercentageLabel = {
        let label = UILabel()
        label.font = .caption2SemiBold
        label.textColor = .black13
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var needPercentageLabel = {
        let label = UILabel()
        label.font = .caption2SemiBold
        label.textColor = .black13
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var wantPercentageLabel = {
        let label = UILabel()
        label.font = .caption2SemiBold
        label.textColor = .black13
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var barStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .black5
        stackView.layer.cornerRadius = 6
        stackView.clipsToBounds = true
        stackView.anchor(height: 12)
        return stackView
    }()
    
    lazy var goalBar = {
        let view = UIView()
        view.backgroundColor = .secondary
        return view
    }()
    
    lazy var needBar = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    
    lazy var wantBar = {
        let view = UIView()
        view.backgroundColor = .accentRed
        return view
    }()
    
    private lazy var descriptionStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var goalDescriptionLabel = {
        let label = UILabel()
        label.text = "Tabungan"
        label.font = .caption2Medium
        label.textColor = .black10
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var needDescriptionLabel = {
        let label = UILabel()
        label.text = "Pokok"
        label.font = .caption2Medium
        label.textColor = .black10
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var wantDescriptionLabel = {
        let label = UILabel()
        label.text = "Nonpokok"
        label.font = .caption2Medium
        label.textColor = .black10
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var goalBarWidthConstraint: NSLayoutConstraint?
    var needBarWidthConstraint: NSLayoutConstraint?
    var wantBarWidthConstraint: NSLayoutConstraint?
    
    func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        addSubview(rootStackView)
        rootStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 4)
        
        rootStackView.addArrangedSubview(percentageStackView)
        rootStackView.addArrangedSubview(barStackView)
        rootStackView.addArrangedSubview(descriptionStackView)
        
        barStackView.addArrangedSubview(goalBar)
        barStackView.addArrangedSubview(needBar)
        barStackView.addArrangedSubview(wantBar)
        barStackView.addArrangedSubview(UIView())
        
        percentageStackView.addArrangedSubview(goalPercentageLabel)
        percentageStackView.addArrangedSubview(needPercentageLabel)
        percentageStackView.addArrangedSubview(wantPercentageLabel)
        percentageStackView.addArrangedSubview(UIView())
        
        descriptionStackView.addArrangedSubview(goalDescriptionLabel)
        descriptionStackView.addArrangedSubview(needDescriptionLabel)
        descriptionStackView.addArrangedSubview(wantDescriptionLabel)
        descriptionStackView.addArrangedSubview(UIView())
        
        goalPercentageLabel.widthAnchor.constraint(equalTo: goalBar.widthAnchor).isActive = true
        goalDescriptionLabel.widthAnchor.constraint(equalTo: goalBar.widthAnchor).isActive = true
        
        needPercentageLabel.widthAnchor.constraint(equalTo: needBar.widthAnchor).isActive = true
        needDescriptionLabel.widthAnchor.constraint(equalTo: needBar.widthAnchor).isActive = true
        
        wantPercentageLabel.widthAnchor.constraint(equalTo: wantBar.widthAnchor).isActive = true
        wantDescriptionLabel.widthAnchor.constraint(equalTo: wantBar.widthAnchor).isActive = true
    }
    
    func adjustWidth(goal: Double, need: Double, want: Double, income: Double) {
        let goalRatio = goal/income
        let needRatio = need/income
        let wantRatio = want/income
        
        goalBarWidthConstraint?.isActive = false
        needBarWidthConstraint?.isActive = false
        wantBarWidthConstraint?.isActive = false
        
        goalBarWidthConstraint = goalBar.widthAnchor.constraint(equalTo: barStackView.widthAnchor, multiplier: goalRatio)
        needBarWidthConstraint = needBar.widthAnchor.constraint(equalTo: barStackView.widthAnchor, multiplier: needRatio)
        wantBarWidthConstraint = wantBar.widthAnchor.constraint(equalTo: barStackView.widthAnchor, multiplier: wantRatio)
        
        goalBarWidthConstraint?.isActive = true
        needBarWidthConstraint?.isActive = true
        wantBarWidthConstraint?.isActive = true
        
        goalPercentageLabel.text = "\(Int(goalRatio*100))%"
        needPercentageLabel.text = "\(Int(needRatio*100))%"
        wantPercentageLabel.text = "\(Int(wantRatio*100))%"
    }
}
