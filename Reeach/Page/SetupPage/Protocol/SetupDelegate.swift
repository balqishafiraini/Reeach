//
//  SetupDelegate.swift
//  Reeach
//
//  Created by James Christian Wira on 15/11/22.
//

import Foundation

@objc protocol SetupDelegate: AnyObject {
    @objc optional func updateProgress()
    @objc optional func previousProgress()
    func openGoalAllocationSheet()
    func openCategoryAllocationSheet(type: String)
    
    @objc optional func openGoalSheet(forGoalIndex: Int)
    @objc optional func saveIncome(income: String)
    func openBudgetDetail(budget: Budget)
    @objc optional func setDisableButton()
}
