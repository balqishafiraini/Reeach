//
//  DashboardDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 09/11/22.
//

import Foundation

protocol DashboardViewDelegate: AnyObject {
    func goToAllGoals()
    func goToAllTransactions()
    func goToAllBudgets()
    func addGoal()
    func goToTipDetail(tip: Tip)
}
