//
//  SetupProgressHeader.swift
//  Reeach
//
//  Created by James Christian Wira on 24/10/22.
//

import UIKit

class SetupProgressHeader: UIView {

    weak var controller: SetupPageViewController?
    
    var progressBar: UIProgressView = {
        var view = UIProgressView(progressViewStyle: .bar)
        
        view.trackTintColor = UIColor(named: "neutral5")
        view.tintColor = UIColor(named: "secondary6")
        
        return view
    }()
    
    var progressValue: Float = 0.0
    
    init(frame: CGRect, controller: SetupPageViewController) {
        self.controller = controller
        
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
    
    func setupView() {
        self.setDimensions(width: UIScreen.main.bounds.width - 32, height: 50)
        
        self.addSubview(progressBar)
        
        progressBar.setProgress(progressValue, animated: true)
        progressBar.center(inView: self)
        progressBar.anchor(width: UIScreen.main.bounds.width - 32)
    }
}
