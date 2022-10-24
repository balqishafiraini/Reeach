//
//  SetupBottomView.swift
//  Reeach
//
//  Created by James Christian Wira on 24/10/22.
//

import UIKit

class SetupBottomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        self.backgroundColor = .orange
        self.setDimensions(width: UIScreen.main.bounds.width, height: 100)
        
        let nextButton: Button = {
            let button = Button(style: .rounded, foreground: .black, background: .tangerineYellow, title: "Selanjutnya")
            
            button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
            
            return button
        }()
        
        self.addSubview(nextButton)
        
        nextButton.center(inView: self)
    }
    
    @objc func nextStep() {
        print("Next next")
    }
}
