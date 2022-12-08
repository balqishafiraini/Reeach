//
//  CashflowTrackerDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 02/12/22.
//

import Foundation

protocol CashflowTrackerViewDelegate: AnyObject {
    func goToBudgetPlanner()
    func goToAllTransactions()
    func changeMonth(next: Bool)
}
