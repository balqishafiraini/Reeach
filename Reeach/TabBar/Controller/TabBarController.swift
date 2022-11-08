//
//  TabBarController.swift
//  Reeach
//
//  Created by Balqis on 08/11/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboardVC = DashboardVC()
        let goalsVC = GoalsVC()
        let cashflowVC = CashflowVC()
        let plannerVC = PlannerVC()
        setViewControllers([dashboardVC, goalsVC, cashflowVC, plannerVC], animated: false)
        
        dashboardVC.title = "Dashboard"
        goalsVC.title = "Goals"
        cashflowVC.title = "Cashflow"
        plannerVC.title = "Planner"
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "list.bullet.rectangle", "list.clipboard", "doc.on.clipboard"]
        
        for x in 0...3 {
            items[x].image = UIImage(systemName: images[x])
        }
        tabBar.tintColor = .ghostWhite
        tabBar.backgroundColor = .royalHunterBlue
        tabBar.barTintColor = .ghostWhite
        
    }

}

class DashboardVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class GoalsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

class CashflowVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}

class PlannerVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}
