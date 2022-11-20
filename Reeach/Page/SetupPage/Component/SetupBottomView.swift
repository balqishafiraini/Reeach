//
//  SetupBottomView.swift
//  Reeach
//
//  Created by James Christian Wira on 24/10/22.
//

import UIKit

class SetupBottomView: UIView {
    
    weak var delegate: SetupDelegate?
    
    let backButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangelo, title: "Kembali ke income")
        
        return button
    }()
    
    let nextButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Looking good? Lanjut, yuk!")
        
        return button
    }()
    
    let stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 12
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        self.setDimensions(width: UIScreen.main.bounds.width, height: 150)
//        self.backgroundColor = .red
        
        stackButton.addArrangedSubview(backButton)
        stackButton.addArrangedSubview(nextButton)
        
//        self.addSubview(nextButton)
        self.addSubview(stackButton)
        
        stackButton.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor, paddingTop: 20)
        
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
//        nextButton.anchor(width: UIScreen.main.bounds.width - 32, height: 100)
        
        backButton.addTarget(self, action: #selector(prevStep), for: .touchUpInside)
//        backButton.anchor(width: UIScreen.main.bounds.width - 32)
    }
    
    @objc func nextStep() {
        delegate?.updateProgress!()
    }
    
    @objc func prevStep() {
        delegate?.previousProgress!()
    }
    
    func setButtonTitle(progressIndex: Float){
        switch progressIndex {
        case 0:
            nextButton.setTitle("Looking good? Lanjut, yuk!", for: .normal)
        case 1:
            nextButton.setTitle("Skuy ke Budgeting!", for: .normal)
        case 2:
            nextButton.setTitle("Yuhuuu, beres!", for: .normal)
        default:
            nextButton.setTitle("Hmm I'm not supposed to be here", for: .normal)
        }
    }
}
