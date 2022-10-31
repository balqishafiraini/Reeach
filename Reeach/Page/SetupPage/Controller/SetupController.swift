//
//  SetupViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 25/10/22.
//

import Foundation

protocol SetupDelegate: AnyObject {
    func updateProgress(progress: Float, progressIndex: Float)
    func previousProgress(progress: Float, progressIndex: Float)
}

class SetupController {    
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
        
        print("updateCurrentProgress \(currentProgress)")
        
        return currentProgress
    }
    
    func previousProgress() -> Float {
        self.currentProgressIndex -= 1.0
        currentProgress = currentProgressIndex / totalProgress
        
        print("previousCurrentProgress \(currentProgress)")
        
        return currentProgress
    }
    
    
}
