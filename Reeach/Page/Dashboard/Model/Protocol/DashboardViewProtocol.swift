//
//  DashboardViewProtocol.swift
//  Reeach
//
//  Created by William Chrisandy on 09/11/22.
//

import Foundation

protocol DashboardViewProtocol: AnyObject {
    func goToAllGoals()
    func addGoal()
    func goToTipDetail(tip: Tip)
}
