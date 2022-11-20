//
//  MonthlyPlanningViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 16/11/22.
//

import Foundation

extension MonthlyPlanningViewController: PlannerDelegate {
    func getPlanner(forDate: Date) {
        setupInitialState(date: forDate)
    }
    
    func goToBudgetPlanner() {
        let targetViewController = SetupPageViewController()
        targetViewController.modalPresentationStyle = .fullScreen
        present(targetViewController, animated: true)
    }
}
