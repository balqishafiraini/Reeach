//
//  Character+Extension.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import Foundation

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}
