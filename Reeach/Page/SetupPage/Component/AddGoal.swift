//
//  AddGoal.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

class AddGoal: UIView {
    
    let topTitle: UILabel = {
        let label = UILabel()
        label.text = "Goal"
        label.font = .largeTitle
        label.anchor(height: 40)
        
        return label
    }()
    
    let addButton: UIButton = {
        let button = Button(style: .circle, foreground: .primary, background: .tangerineYellow, image: UIImage(systemName: "plus"))
        
        return button
    }()
    
    let topStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        stack.anchor(height: 40)
        
        return stack
    }()
    
    let viewDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Yuk tambah tujuan finansial mu sekarang, tujuan finansialmu harus SMART, yaitu  Lorem ipsum dolor sit amet sit ."
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
    
    
    let emptyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "EmptyImage")
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return image
    }()
    
    let emptyDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Klik '+' untuk menambah target"
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        
        self.addSubview(headerStack)
        self.addSubview(emptyView)
        
        addButton.addTarget(self, action: #selector(openGoalSheet), for: .touchUpInside)
    
        emptyView.addSubview(emptyImage)
        emptyView.addSubview(emptyDescription)
        
        emptyImage.center(inView: emptyView)
        emptyDescription.anchor(top: emptyImage.bottomAnchor, paddingTop: 12)
        emptyDescription.centerX(inView: emptyView)
        
        headerStack.addArrangedSubview(topStack)
        headerStack.addArrangedSubview(viewDescription)
        
        topStack.addArrangedSubview(topTitle)
        topStack.addArrangedSubview(addButton)
        
        headerStack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        topStack.anchor(top: headerStack.topAnchor, left: headerStack.leftAnchor, right: headerStack.rightAnchor)
        
        emptyView.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    // TODO: Open sheet here
    @objc func openGoalSheet() {
        print("Opening Goal Sheet")
    }
}


