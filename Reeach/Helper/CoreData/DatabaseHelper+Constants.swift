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
    func insertDefaultCategory() {        
        let _ = createCategory(name: "Income", type: "Income", icon: "💵")
        let _ = createCategory(name: "Makanan", type: "Need", icon: "🍕")
        let _ = createCategory(name: "Pakaian", type: "Need", icon: "👕")
        let _ = createCategory(name: "Pendidikan", type: "Need", icon: "📚")
        let _ = createCategory(name: "Listrik", type: "Need", icon: "💡")
        let _ = createCategory(name: "Air", type: "Need", icon: "💧")
        let _ = createCategory(name: "Tempat tinggal", type: "Need", icon: "🏠")
        let _ = createCategory(name: "Perawatan diri", type: "Need", icon: "🧴")
        let _ = createCategory(name: "Kesehatan", type: "Need", icon: "🩺")
        let _ = createCategory(name: "Belanja bulanan", type: "Need", icon: "🛒")
        let _ = createCategory(name: "Transportasi", type: "Need", icon: "🚕")
        let _ = createCategory(name: "Pulsa", type: "Need", icon: "️️☎️")
        let _ = createCategory(name: "Hewan peliharaan", type: "Need", icon: "🐶")
        let _ = createCategory(name: "Belanja", type: "Want", icon: "🛍")
        let _ = createCategory(name: "Hobi", type: "Want", icon: "🎮")
        let _ = createCategory(name: "Hiburan", type: "Want", icon: "🎉")
        let _ = createCategory(name: "Langganan", type: "Want", icon: "💳")
        let _ = createCategory(name: "Jalan-jalan", type: "Want", icon: "👣")
    }
}
