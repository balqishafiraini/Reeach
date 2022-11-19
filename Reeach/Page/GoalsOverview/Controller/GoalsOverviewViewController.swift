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
        goalsOverviewView.headerView.goalName.text = goal.name
        goalsOverviewView.headerView.termLabel.text = "\(goal.timeTerm ?? "Unknown")-term"
        goalsOverviewView.headerView.amount.text = CurrencyHelper.getCurrency(from: goal.targetAmount)
        goalsOverviewView.deadlineView.date.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
        
        if goal.isActive(on: Date()) {
            goalsOverviewView.statusView.image.image = UIImage(named: "IllustrationActive")
            goalsOverviewView.statusView.date.text = "Goal Aktif"
            goalsOverviewView.headerView.editButton.isHidden = true
        }
        else {
            goalsOverviewView.statusView.image.image = UIImage(named: "IllustrationInactive")
            goalsOverviewView.statusView.date.text = "Goal Nonaktif"
            goalsOverviewView.messageLabel.isHidden = true
        }
    }
}
