//
//  UserDefaultEnum.swift
//  Reeach
//
//  Created by James Christian Wira on 20/10/22.
//

import Foundation

class UserDefaultEnum {
    public var inflationRate:String = "INFLATION_RATE"
    public var inflationYear:String = "INFLATION_YEAR"
    
    var keys = ["INFLATION_RATE", "INFLATION_YEAR"]
    
    func removeAllKey() {
        print("Deleting key and value for checking")
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
        print("Deleting key done :)")
    }
}
