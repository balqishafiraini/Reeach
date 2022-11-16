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
    
    @objc optional func openGoalSheet()
    
    @objc optional func addBudget(type: String, budget: Budget)
    @objc optional func saveIncome(income: String)
}

protocol BudgetDelegate: AnyObject {
    func addBudget()
}

class SetupPageViewController: UIViewController {
    
    let contentView = SetupPageView()
    
    var currentProgress: Float = 0.0
    var currentProgressIndex: Float = 0.0
    let totalProgress: Float = 2.0
    
    var income: Float = 0.0
    
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
        shouldDisableButton(progressIndex: currentProgressIndex)
        contentView.bottomView.setButtonTitle(progressIndex: currentProgressIndex)
        contentView.setupContentView()
        contentView.progressHeader.progressBar.setProgress(currentProgress, animated: true)
        contentView.progressHeader.updateSteps(currentIndex: currentProgressIndex)
    }
    
    func shouldDisableButton(progressIndex: Float){
        switch progressIndex {
        case 1.0:
            if income == 0.0 {
                contentView.bottomView.nextButton.isEnabled = false
            } else {
                contentView.bottomView.nextButton.isEnabled = true
            }
        default:
            contentView.bottomView.nextButton.isEnabled = true
        }
    }
}