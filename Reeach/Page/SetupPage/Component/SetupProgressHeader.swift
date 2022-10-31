//
//  SetupProgressHeader.swift
//  Reeach
//
//  Created by James Christian Wira on 24/10/22.
//

import UIKit

class SetupProgressHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: SetupDelegate!
    var controller: SetupController?
    
    var progressBar: UIProgressView = {
        var view = UIProgressView(progressViewStyle: .bar)
        
        // TODO: Update progress setiap next ke tempat selanjutnya
        view.trackTintColor = UIColor(named: "neutral5")
        view.tintColor = UIColor(named: "secondary6")
//        view.progressTintColor = UIColor(named: "secondary6")
        
        return view
    }()
    
    var progressValue: Float = 0.0 {
        didSet{
//            print("\(#function) \(oldValue) to \(progressValue)")
            DispatchQueue.main.async {
                self.progressBar.setProgress(self.progressValue, animated: true)
            }
        }
    }
    
    
    init(frame: CGRect, controller: SetupController) {
        self.controller = controller
        
        super.init(frame: frame)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.setDimensions(width: UIScreen.main.bounds.width, height: 50)
        
        self.addSubview(progressBar)
        
        progressBar.setProgress(progressValue, animated: true)
        progressBar.center = self.center
        
        progressBar.center(inView: self)
        progressBar.anchor(width: UIScreen.main.bounds.width - 32)
    }
}

extension SetupProgressHeader: SetupDelegate {
    func updateProgress(progress: Float, progressIndex: Float) {
        progressValue += 0.1
        
//        self.progressBar.setProgress(progress, animated: true)
//        DispatchQueue.main.async {
//            self.progressBar.setProgress(self.progressValue, animated: true)
//        }

    }
    
    func previousProgress(progress: Float, progressIndex: Float) {
//        print("previous in progress")
    }
    
}
