//
//  MonthlyPlanningViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningViewController: UIViewController {

    let planningView = MonthlyPlanningView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = planningView
    }

}
