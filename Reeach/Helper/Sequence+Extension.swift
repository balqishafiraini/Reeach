//
//  Sequence+Extension.swift
//  Reeach
//
//  Created by James Christian Wira on 09/12/22.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
