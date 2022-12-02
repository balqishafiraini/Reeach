//
//  CashflowTrackerDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 02/12/22.
//

import Foundation

protocol CashflowTrackerViewDelegate: AnyObject {
    func goToBudgetPlanner()
    func goToAllTransaction()
    func changeMonth(next: Bool)
}
