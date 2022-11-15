//
//  GoalTrackerViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import UIKit

class GoalTrackerViewController: UIViewController {
    var terms: [String] = []
    var goals: [[Goal]] = []
    
    var contentView = GoalTrackerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Lalala")
        goals = Goal.categorizeGoals(goals: DatabaseHelper().getAllocatedGoals(on: Date()))
        
        terms.removeAll()
        for goal in goals {
            terms.append(goal[0].timeTerm ?? "Unknown Term")
        }
        
        if goals.isEmpty {
            contentView.goalTermContainerView.isHidden = true
            contentView.addGoalButton.isHidden = true
            contentView.titleExplanationLabel.text = "Semua goals yang udah kamu buat."
        }
        else {
            contentView.emptyStateContainerView.isHidden = true
            contentView.emptyGoalButton.isHidden = true
            contentView.titleExplanationLabel.text = "Semua goals yang kamu budget bulan ini."
            contentView.emptyDescriptionLabel.text = "Kamu belum memiliki goals tidak aktif"
            contentView.centerYEmptyContainerViewConstraint.constant = 100
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureView(viewController: self)
    }
}
