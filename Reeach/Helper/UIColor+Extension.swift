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
    static let tangerineYellow = UIColor(named: "tangerineYellow")
    static let royalHunterBlue = UIColor(named: "royalHunterBlue")
    static let tangelo = UIColor(named: "tangelo")
    static let caribbeanGreen = UIColor(named: "caribbeanGreen")
    static let darkSlateGrey = UIColor(named: "darkSlateGrey")
    static let ghostWhite = UIColor(named: "ghostWhite")
    static let whiteSmoke = UIColor(named: "whiteSmoke")
    static let crimson = UIColor(named: "crimson")
}
