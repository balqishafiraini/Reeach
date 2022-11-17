//
//  MonthlyPlanningViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningViewController: UIViewController {

    let planningView = MonthlyPlanningView()
    
    var currentDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = planningView
        planningView.delegate = self
        planningView.setupDate(currentDate: currentDate)
    }

    override func viewWillAppear(_ animated: Bool) {
        getPlanner(forDate: DateFormatHelper.getStartDateOfMonth(of: Date()))
    }
}
