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
    var cellHeight: Double = 188
    
    var contentView = GoalTrackerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cellHeight = 188
        loadData()
    }
    
    func loadData() {
        let isSet = UserDefaults.standard.bool(forKey: DateFormatHelper.getShortMonthAndYearString(from: Date()))
        goals = Goal.categorizeGoals(goals: DatabaseHelper.shared.getAllocatedGoals(on: Date()))
        
        terms.removeAll()
        for goal in goals {
            terms.append(goal[0].timeTerm ?? "Unknown Term")
        }
        
        if !isSet {
            contentView.goalTermContainerView.isHidden = true
            contentView.addGoalButton.isHidden = true
            contentView.titleExplanationLabel.text = "Semua goals yang udah kamu buat."
            
            contentView.emptyStateContainerView.isHidden = false
            contentView.emptyGoalButton.isHidden = false
            contentView.emptyDescriptionLabel.text = "Tahu gak sih, bikin goals itu langkah pertama untuk financial planning lho."
            contentView.centerYEmptyContainerViewConstraint.constant = 20
            
            contentView.collectionView.isHidden = true
        }
        else {
            contentView.goalTermContainerView.isHidden = false
            contentView.addGoalButton.isHidden = false
            contentView.titleExplanationLabel.text = "Semua goals yang kamu budget bulan ini."
            
            contentView.emptyStateContainerView.isHidden = true
            contentView.emptyGoalButton.isHidden = true
            contentView.emptyDescriptionLabel.text = "Kamu belum memiliki goals tidak aktif"
            contentView.centerYEmptyContainerViewConstraint.constant = 120
            
            contentView.collectionView.isHidden = false
        }
        contentView.activeButton.setIsActive(.active)
        contentView.inActiveButton.setIsActive(.inactive)
        contentView.collectionView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureView(viewController: self)
    }
}
