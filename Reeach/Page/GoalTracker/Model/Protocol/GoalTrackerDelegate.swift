//
//  GoalTrackerDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import Foundation

protocol GoalTrackerViewDelegate: AnyObject {
    func goToBudgetPlanner()
    func addGoal()
    func changeGoalStatusData(_ status: String)
}
