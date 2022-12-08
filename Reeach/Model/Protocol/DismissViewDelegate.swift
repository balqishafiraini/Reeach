//
//  DismissViewDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import Foundation

@objc protocol DismissViewDelegate: AnyObject {
    @objc optional var viewControllerTitle: String { get }
    func viewDismissed()
}
