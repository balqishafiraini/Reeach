//
//  GoalsOverviewViewController.swift
//  Reeach
//
//  Created by Balqis on 15/11/22.
//

import UIKit

class GoalsOverviewViewController: UIViewController {
    var goal: Goal?
    let goalsOverviewView = GoalsOverviewView()

    override func viewDidLoad() {
        super.viewDidLoad()
        goalsOverviewView.configureView(viewController: self)
        view = goalsOverviewView
        updateContent()
    }
    
    func updateContent() {
        guard let goal
        else { return }
        
        goalsOverviewView.headerView.iconLabel.text = goal.icon
        goalsOverviewView.headerView.goalNameLabel.text = goal.name
        goalsOverviewView.headerView.termLabel.text = "\(goal.timeTerm ?? "Unknown")-term"
        
        let initialSaving = goal.initialSaving(before: Date())
        
        goalsOverviewView.headerView.initialSavingValueLabel.text = CurrencyHelper.getCurrency(from: initialSaving)
        goalsOverviewView.headerView.targetAmountValueLabel.text = CurrencyHelper.getCurrency(from: goal.targetAmount)
        
        let progress = initialSaving/goal.targetAmount
        goalsOverviewView.progressView.setProgress(Float(progress), animated: false)
        goalsOverviewView.percentageLabel.text = "\(CurrencyHelper.getFormattedNumber(from: progress*100))% tercapai"
        
        goalsOverviewView.deadlineView.dueDateLabel.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
        
        if goal.isActive(on: Date()) {
            goalsOverviewView.messageLabelContainerView.isHidden = false
            goalsOverviewView.headerView.editButton.isHidden = true
            goalsOverviewView.statusView.imageView.image = UIImage(named: "IllustrationActive")
            goalsOverviewView.statusView.statusLabel.text = "Goal Aktif"
        }
        else {
            goalsOverviewView.messageLabelContainerView.isHidden = true
            goalsOverviewView.headerView.editButton.isHidden = false
            goalsOverviewView.statusView.imageView.image = UIImage(named: "IllustrationInactive")
            goalsOverviewView.statusView.statusLabel.text = "Goal Nonaktif"
        }
    }
}
