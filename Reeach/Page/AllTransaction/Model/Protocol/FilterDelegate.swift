//
//  PickerDelegate.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import Foundation

protocol FilterDelegate: AnyObject {
    func selected(selectedItem: String)
    func openPicker(type: String)
    func filterTransaction()
}
