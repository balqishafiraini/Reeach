//
//  AddBudgetViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 19/11/22.
//

import Foundation

extension AddBudgetViewController: DismissViewDelegate {
    func viewDismissed() {
        viewWillAppear(false)
    }
}
