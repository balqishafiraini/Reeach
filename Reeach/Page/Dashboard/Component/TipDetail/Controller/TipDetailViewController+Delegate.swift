//
//  TipDetailViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 17/11/22.
//

import UIKit

extension TipDetailViewController: NavigationBarDelegate {
    func cancel() {
        dismiss(animated: true)
    }
}
