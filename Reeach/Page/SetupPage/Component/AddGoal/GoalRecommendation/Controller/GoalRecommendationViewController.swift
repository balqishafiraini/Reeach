//
//  GoalRecommendationViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

class GoalRecommendationViewController: UIViewController {
    let terms = ["Short", "Medium", "Long"]
    let goals = DatabaseHelper().getGoalRecommendations()
    weak var delegate: GoalRecommendationViewControllerDelegate?
    var contentView = GoalRecommendationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        title = "Rekomendasi Goal"
        view = contentView
        contentView.configureView(viewController: self)
    }
}
