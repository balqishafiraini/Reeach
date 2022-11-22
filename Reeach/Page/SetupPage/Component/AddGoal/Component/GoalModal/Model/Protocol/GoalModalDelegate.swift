//
//  GoalModalDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import Foundation

protocol GoalModalViewDelegate: AnyObject {
    func goToTermPicker()
    func goToGoalRecommendation()
    func goToInflationDetail()
    func save(name: String, icon: String, dueDate: Date, targetAmount: Double, timeTerm: String, initialSaving: Double)
    func updateInflationButton()
}
