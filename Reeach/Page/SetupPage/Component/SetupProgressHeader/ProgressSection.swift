//
//  ProgressSection.swift
//  Reeach
//
//  Created by James Christian Wira on 14/11/22.
//

import UIKit

class ProgressSection: UIView {

    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2SemiBold
        label.textColor = UIColor(named: "black8")
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var numberView: UIView = {
        let view = UIView()
        view.anchor(width: 32, height: 32)
        view.backgroundColor = UIColor(named: "neutral6")
        view.addSubview(numberLabel)
        view.layer.cornerRadius = 16
        
        numberLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 10, paddingBottom: 6, paddingRight: 10)
        
        return view
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2SemiBold
        label.textColor = UIColor(named: "black8")
        label.textAlignment = .center
        
        return label
    }()
    
    init(frame: CGRect, progressNumber: String, progressLabel: String, isActive: Bool? = false) {
        super.init(frame: frame)
        
        self.numberLabel.text = progressNumber
        self.progressLabel.text = progressLabel
        
        if isActive! {
            self.numberLabel.textColor = .white
            self.numberView.backgroundColor = UIColor(named: "secondary6")
            self.progressLabel.textColor = UIColor(named: "secondary6")
        }
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numberLabel.text = "0"
        self.progressLabel.text = "Nothing here"
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.addSubview(numberView)
        self.addSubview(progressLabel)
        
        numberView.centerX(inView: self, topAnchor: self.topAnchor)
        
        progressLabel.centerX(inView: self, topAnchor: numberView.bottomAnchor, paddingTop: 8)
        
        NSLayoutConstraint.activate([
            progressLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func updateView(isActive: Bool? = false) {
        if isActive! {
            self.numberLabel.textColor = .white
            self.numberView.backgroundColor = UIColor(named: "secondary6")
            self.progressLabel.textColor = UIColor(named: "secondary6")
        } else {
            self.numberLabel.textColor = UIColor(named: "black8")
            self.numberView.backgroundColor = UIColor(named: "neutral6")
            self.progressLabel.textColor = UIColor(named: "black8")
        }
    }
}
