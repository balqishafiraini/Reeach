//
//  CategoryAllocationDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import Foundation

protocol CategoryAllocationModalViewDelegate: AnyObject {
    func goToSelectCategory()
    func save(monthlyAllocation: Double)
    func delete()
    func updateRemainingLabel()
    func validate(monthlyAllocation: Double)
}
