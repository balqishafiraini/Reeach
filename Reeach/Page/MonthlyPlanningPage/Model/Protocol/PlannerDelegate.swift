//
//  PlannerDelegate.swift
//  Reeach
//
//  Created by James Christian Wira on 16/11/22.
//

import Foundation

protocol PlannerDelegate: AnyObject {
    func getPlanner(forDate: Date)
    func goToBudgetPlanner()
}
