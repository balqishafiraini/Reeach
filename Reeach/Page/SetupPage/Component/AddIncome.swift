//
//  AddIncome.swift
//  Reeach
//
//  Created by James Christian Wira on 25/10/22.
//

import UIKit

class AddIncome: UIView {
    
    var progressDelegate: SetupDelegate!
    var bottomDelegate: SetupDelegate!
    var viewDelegate: SetupDelegate!
    var controller: SetupPageViewController?
    
    init(frame: CGRect, viewDelegate: SetupPageView) {
        self.viewDelegate = viewDelegate
        
        super.init(frame: frame)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topTitle: UILabel = {
        let label = UILabel()
        label.text = "Pemasukan"
        label.font = .largeTitle
        
        label.anchor(height: 40)
        
        return label
    }()
    
    let viewDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Masukkan pemasukan bulanan mu disini, lorem ipsum dolor sit amet, consectetur adipiscing elit consectetur adipiscing. "
        label.font = .bodyMedium
        label.numberOfLines = 5
        
        return label
    }()
    
    let incomeTextField: TextField = {
        let textField = TextField(frame: .zero, style: .active)
        
        return textField
    }()
    
    let headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        
        return stack
    }()
    
    let backButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangelo, title: "Balik ke Goal-Setting")
        
        return button
    }()
    
    let contentStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    let goalStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        
        let label = UILabel()
        label.text = "Goal"
        label.font = .headline
        
        let addButton = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(addButton)
        
        return stack
    }()
    
    
    func setupView() {
        headerStack.addArrangedSubview(topTitle)
        headerStack.addArrangedSubview(viewDescription)
        // TODO: Add text field
        headerStack.addArrangedSubview(incomeTextField)
        
        contentStack.addArrangedSubview(headerStack)
        contentStack.addArrangedSubview(backButton)
        
        
        self.addSubview(contentStack)
        
        backButton.addTarget(self, action: #selector(prevStep), for: .touchUpInside)
        
        contentStack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
    
    @objc func prevStep() {
        let progress = controller?.previousProgress() ?? 0.0
        let progressIndex = controller?.currentProgressIndex ?? 0.0
        
        progressDelegate?.updateProgress(progress: progress, progressIndex: progressIndex)
        bottomDelegate?.updateProgress(progress: progress, progressIndex: progressIndex)
        viewDelegate?.updateProgress(progress: progress, progressIndex: progressIndex)
    }
}
