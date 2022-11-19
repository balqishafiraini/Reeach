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
<<<<<<< HEAD
    func openGoalAllocationSheet()
    func openCategoryAllocationSheet(type: String)
    @objc optional func openGoalSheet()
=======
    
    @objc optional func openGoalSheet(forGoalIndex: Int)
>>>>>>> a317114 (Fix: Previous change cause error)
    @objc optional func saveIncome(income: String)
    func openBudgetDetail(budget: Budget)
    @objc optional func setDisableButton()
}
