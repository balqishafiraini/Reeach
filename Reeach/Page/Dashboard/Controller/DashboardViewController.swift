//
//  DashboardViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class DashboardViewController: UIViewController {
    var goals = DatabaseHelper.shared.getAllocatedGoals(on: Date())
    let tips = Tip.allTips
    
    var contentView = DashboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.greetingLabel.text = DateFormatHelper.getGreeting(from: Date())
        loadData()
    }
    
    func loadData() {
        let isSet = UserDefaults.standard.bool(forKey: DateFormatHelper.getShortMonthAndYearString(from: Date()))
        
        goals = DatabaseHelper.shared.getAllocatedGoals(on: Date())
        
        if !isSet {
            contentView.goalCollectionView.isHidden = true
            contentView.emptyGoalButton.isHidden = false
            contentView.emptyGoalLabel.isHidden = false
        }
        else {
            contentView.goalCollectionView.isHidden = false
            contentView.emptyGoalButton.isHidden = true
            contentView.emptyGoalLabel.isHidden = true
        }
        
        contentView.goalCollectionView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureTipCards(tips: tips)
        contentView.configureView(viewController: self)
    }
}
