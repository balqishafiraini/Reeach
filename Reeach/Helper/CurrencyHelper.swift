//
//  CurrencyHelper.swift
//  Reeach
//
//  Created by William Chrisandy on 06/10/22.
//

import Foundation

class CurrencyHelper {
    static func getFormattedNumber(from number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.decimalSeparator = ","
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    
    static func getCurrency(from number: Double) -> String {
        return "Rp" + getFormattedNumber(from: number)
    }
    
    static func roundUp(_ double: Double) -> Double {
        var result = double
        result *= 100
        result.round(.up)
        result /= 100.00
        
        return result
    }
}
