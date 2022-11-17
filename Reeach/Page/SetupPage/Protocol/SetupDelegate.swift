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
    
    @objc optional func openGoalSheet()
    
    @objc optional func addBudget(type: String, budget: Budget)
    @objc optional func saveIncome(income: String)
}
