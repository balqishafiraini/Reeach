//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

protocol SetupDelegate: AnyObject {
    func updateProgress(progress: Float, progressIndex: Float)
//    func previousProgress(progress: Float, progressIndex: Float)
}

class SetupPageViewController: UIViewController {
    
    let contentView = SetupPageView()
    
    var currentProgress: Float = 0.0
    var currentProgressIndex: Float = 0.0
    let totalProgress: Float = 2.0
    
    func updateProgress() -> Float {
        self.currentProgressIndex += 1.0
        currentProgress = currentProgressIndex / totalProgress
        
        if currentProgressIndex > totalProgress {
            currentProgress = 0.0
            currentProgressIndex = 0.0
        }
        
        return currentProgress
    }
    
    func previousProgress() -> Float {
        self.currentProgressIndex -= 1.0
        currentProgress = currentProgressIndex / totalProgress
        
        return currentProgress
    }
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        view = contentView
        contentView.configureView(viewController: self)
    }

}
