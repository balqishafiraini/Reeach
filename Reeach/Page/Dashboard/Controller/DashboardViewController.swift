//
//  DashboardViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class DashboardViewController: UIViewController {
    let goals = DatabaseHelper().getAllocatedGoals(on: Date())
    let tips = Tip.allTips
    
    var contentView = DashboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if goals.isEmpty {
            contentView.collectionView.isHidden = true
        }
        else {
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
