//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

@objc protocol SetupDelegate: AnyObject {
    @objc optional func updateProgress()
    @objc optional func previousProgress()
    @objc optional func addBudget(type: String, budget: Budget)
}

class SetupPageViewController: UIViewController {
    
    let contentView = SetupPageView()
    
    var currentProgress: Float = 0.0
    var currentProgressIndex: Float = 0.0
    let totalProgress: Float = 2.0
    
    var goalBudgets: [Budget] = []
    var needBudgets: [Budget] = []
    var wantBudgets: [Budget] = []
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        view = contentView
        contentView.configureView(viewController: self)
    }
    
    func updateView() {
        contentView.bottomView.setButtonTitle(progressIndex: currentProgressIndex)
        contentView.setupContentView()
        contentView.progressHeader.progressBar.setProgress(currentProgress, animated: true)
    }

}

extension SetupPageViewController: SetupDelegate {
    
    func updateProgress() {
        currentProgressIndex += 1.0
        currentProgress = currentProgressIndex / totalProgress
        
        if currentProgressIndex > totalProgress {
            currentProgress = 0.0
            currentProgressIndex = 0.0
        }
        
        updateView()
    }
    
    func previousProgress() {
        currentProgressIndex -= 1.0
        currentProgress = currentProgressIndex / totalProgress
        updateView()
    }
    
    func addBudget(type: String, budget: Budget) {
        print(#function)
        switch type {
        case "Goal":
//            goalBudgets.append(budget)
            let _ = contentView.content as! AddBudget
//            content.goalStack.setupStatusLabel(budgets: goalBudgets)
            
        case "Need":
            needBudgets.append(budget)
        case "Want":
            wantBudgets.append(budget)
        default:
            print("Wtf do u want?")
        }
    }
    
}
