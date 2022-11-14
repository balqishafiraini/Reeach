//
//  DoubleToStringHelper.swift
//  Reeach
//
//  Created by William Chrisandy on 06/10/22.
//

import Foundation

class DoubleToStringHelper {
    static func getString(from number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    
    static func roundUpToString(double: Double) -> String {
        let result = CurrencyHelper.roundUp(double)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: result))!
    }
}
