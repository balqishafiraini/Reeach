//
//  GoalRecommendationViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

class GoalRecommendationViewController: UIViewController {
    var terms: [String] = []
    let goals = DatabaseHelper.shared.getGoalRecommendations()
    weak var delegate: GoalRecommendationViewControllerDelegate?
    var contentView = GoalRecommendationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        terms.removeAll()
        for goal in goals {
            if goal.isEmpty == false {
                terms.append(goal[0].term)
            }
        }
        contentView.collectionView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        title = "Rekomendasi Goal"
        view = contentView
        contentView.configureView(viewController: self)
    }
}
