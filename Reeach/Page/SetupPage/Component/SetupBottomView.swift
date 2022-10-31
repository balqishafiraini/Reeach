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
    
    var delegate: SetupDelegate?
    var viewDelegate: SetupDelegate?
    var controller: SetupController?
    
    let nextButton: Button = {
        let button = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Lanjut ke Pemasukan")
        
        
        return button
    }()
    
    init(frame: CGRect, viewDelegate: SetupPageView) {
        self.delegate = SetupProgressHeader()
        self.viewDelegate = viewDelegate
        
        super.init(frame: frame)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        self.delegate = SetupProgressHeader()
        
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
        let progress = controller?.updateProgress() ?? 0.0
        let progressIndex = controller?.currentProgressIndex ?? 0.0
        
        if progressIndex >= 2 {
            nextButton.setTitle("Yey, Selesai!", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        
        viewDelegate?.updateProgress(progress: progress, progressIndex: progressIndex)
        delegate?.updateProgress(progress: progress, progressIndex: progressIndex)
    }
}
