//
//  DashboardViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class DashboardViewController: UIViewController {
    var goals = DatabaseHelper().getAllocatedGoals(on: Date())
    let tips = Tip.allTips
    
    var contentView = DashboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        goals = DatabaseHelper().getAllocatedGoals(on: Date())
        
        if goals.isEmpty {
            contentView.collectionView.isHidden = true
            contentView.emptyGoalButton.isHidden = false
            contentView.emptyGoalLabel.isHidden = false
        }
        else {
            contentView.collectionView.isHidden = false
            contentView.emptyGoalButton.isHidden = true
            contentView.emptyGoalLabel.isHidden = true
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureTipCards(tips: tips)
        contentView.configureView(viewController: self)
    }
}
