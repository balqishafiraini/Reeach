//
//  DatabaseHelper+Constants.swift
//  Reeach
//
//  Created by William Chrisandy on 13/10/22.
//

import Foundation

protocol AutoIncrementInt64Id {
    var id: Int64 { get set }
    static var keyLastId: String { get }
}

extension DatabaseHelper {
    
}
