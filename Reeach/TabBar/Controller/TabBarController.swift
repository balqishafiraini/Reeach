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
        
        let dashboardVC = DashboardViewController()
        let goalsVC = GoalsVC()
        let cashflowVC = TrackerEmptyStateViewController()
        let plannerVC = MonthlyPlanningViewController()
        
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
        
        // TODO: iOS 14 color ga jalan        
        tabBar.tintColor = .ghostWhite
        tabBar.backgroundColor = .royalHunterBlue
        tabBar.barTintColor = .ghostWhite
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        for tabbarItem in (self.tabBar.items)!{
            let viewTabBar = tabbarItem.value(forKey: "view") as! UIView
            viewTabBar.frame.origin.y = -20
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = UIScreen.main.bounds.height*0.135
        tabBar.frame.origin.y = view.frame.height - 85
    }
}


class GoalsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}
