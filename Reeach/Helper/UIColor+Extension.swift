//
//  UIColorExtension.swift
//  Reeach
//
//  Created by Balqis on 09/10/22.
//

import UIKit
import Foundation

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
}
