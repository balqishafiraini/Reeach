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
    
    @objc optional func openGoalSheet(forGoalIndex: Int)
    @objc optional func saveIncome(income: String)
    
    @objc optional func setDisableButton()
}
