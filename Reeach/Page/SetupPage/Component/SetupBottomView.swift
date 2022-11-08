//
//  SetupBottomView.swift
//  Reeach
//
//  Created by James Christian Wira on 24/10/22.
//

import UIKit

class SetupBottomView: UIView {
    
    weak var delegate: SetupDelegate?
    
    let nextButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Looking good? Lanjut, yuk!")
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.setDimensions(width: UIScreen.main.bounds.width, height: 100)
        
        self.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        nextButton.center(inView: self)
        nextButton.anchor(width: UIScreen.main.bounds.width - 32)
    }
    
    @objc func nextStep() {        
        delegate?.updateProgress!()
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
