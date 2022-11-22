//
//  AddCategoryDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import Foundation

protocol AddCategoryViewDelegate: AnyObject {
    func save(icon: String, name: String)
}
