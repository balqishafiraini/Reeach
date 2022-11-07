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
        stack.spacing = 32
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    let multipleProgress: MultipleProgressBar = {
       let progress = MultipleProgressBar()
        
        return progress
    }()
    
    lazy var goalStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        
        let label = UILabel()
        label.text = "Goal"
        label.font = .headline
        
        let addButton = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        addButton.addTarget(self, action: #selector(addGoalBudget), for: .touchUpInside)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(addButton)
        
        return stack
    }()
    
    lazy var needStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        
        let label = UILabel()
        label.text = "Kebutuhan Pokok"
        label.font = .headline
        
        let addButton = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        addButton.addTarget(self, action: #selector(addNeedBudget), for: .touchUpInside)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(addButton)
        
        return stack
    }()
    
    lazy var wantStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        
        let label = UILabel()
        label.text = "Keinginan"
        label.font = .headline
        
        let addButton = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        addButton.addTarget(self, action: #selector(addWantBudget), for: .touchUpInside)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(addButton)
        
        return stack
    }()
    
    let backButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangelo, title: "Kembali ke income")
        
        return button
    }()
    
    let contentStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private func setupView() {
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        headerStack.addArrangedSubview(multipleProgress)
        headerStack.addArrangedSubview(goalStack)
        headerStack.addArrangedSubview(needStack)
        headerStack.addArrangedSubview(wantStack)
        
        contentStack.addArrangedSubview(headerStack)
        contentStack.addArrangedSubview(backButton)
        
        self.addSubview(contentStack)
        
        backButton.addTarget(self, action: #selector(prevStep), for: .touchUpInside)
        
        contentStack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
    }

    @objc func prevStep() {
        delegate?.previousProgress()
    }
    
    @objc func addGoalBudget() {
        print(#function)
    }
    
    @objc func addNeedBudget() {
        print(#function)
        
    }
    
    @objc func addWantBudget() {
        print(#function)
        
    }
}
