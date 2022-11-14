//
//  InflationDetailViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 01/11/22.
//

import UIKit

extension InflationDetailViewController: NavigationBarDelegate {
    func cancel() {
        navigationController?.popViewController(animated: true)
    }
}
