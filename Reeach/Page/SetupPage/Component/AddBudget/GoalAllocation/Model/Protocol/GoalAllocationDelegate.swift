//
//  GoalAllocationDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 19/11/22.
//

import Foundation

protocol GoalAllocationModalViewDelegate: AnyObject {
    func goToInflationDetail()
    func save(dueDate: Date, targetAmount: Double, montlyAllocation: Double)
    func delete()
    func updateDynamicView()
    func disableButtonIfNotAchivable()
}
