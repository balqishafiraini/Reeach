//
//  String+Extension.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import Foundation
extension String {
    func onlyEmoji() -> String {
        return self.filter({$0.isEmoji})
    }
}
