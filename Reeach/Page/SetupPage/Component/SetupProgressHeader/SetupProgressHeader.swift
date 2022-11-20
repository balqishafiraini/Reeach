//
//  SetupProgressHeader.swift
//  Reeach
//
//  Created by James Christian Wira on 24/10/22.
//

import UIKit

class SetupProgressHeader: UIView {

    weak var controller: SetupPageViewController?
    
    var progressValue: Float = 0.0
    
    lazy var progressBar: UIProgressView = {
        var view = UIProgressView(progressViewStyle: .bar)
        
        view.trackTintColor = .black5
        view.tintColor = .secondary6
        
        return view
    }()
    
    lazy var firstStep = ProgressSection(frame: .zero, progressNumber: "1", progressLabel: "Goal-Setting", isActive: true)
    lazy var secondStep = ProgressSection(frame: .zero, progressNumber: "2", progressLabel: "Pemasukan")
    lazy var thirdStep = ProgressSection(frame: .zero, progressNumber: "3", progressLabel: "Budget")
    
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
        self.backgroundColor = .ghostWhite
        
        self.addSubview(progressBar)
        self.addSubview(firstStep)
        self.addSubview(secondStep)
        self.addSubview(thirdStep)
        
        progressBar.setProgress(progressValue, animated: true)
        progressBar.center(inView: self, yConstant: -8)
        
        firstStep.anchor(left: self.leftAnchor)
        secondStep.centerX(inView: progressBar)
        thirdStep.anchor(right: self.rightAnchor)
        
        NSLayoutConstraint.activate([
            progressBar.leftAnchor.constraint(equalTo: firstStep.numberView.rightAnchor),
            progressBar.rightAnchor.constraint(equalTo: thirdStep.numberView.leftAnchor)
        ])
    }
    
    func updateSteps(currentIndex: Float) {
        firstStep.updateView(isActive: true)
        secondStep.updateView(isActive: currentIndex >= 1.0 ? true : false)
        thirdStep.updateView(isActive: currentIndex >= 2.0 ? true : false)
    }
}
