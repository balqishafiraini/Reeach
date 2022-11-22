//
//  UIFont+Extension.swift
//  Reeach
//
//  Created by Balqis on 22/10/22.
//

import UIKit
import Foundation

extension UIFont {
    static func scriptFont(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "GeneralSans-Regular", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
    
    static let largeTitle = UIFont(name: "GeneralSans-Bold", size: 28)
    static let title = UIFont(name: "GeneralSans-Bold", size: 20)
    static let headline = UIFont(name: "GeneralSans-Semibold", size: 17)
    static let bodyBold = UIFont(name: "GeneralSans-Bold", size: 16)
    static let bodyMedium = UIFont(name: "GeneralSans-Medium", size: 16)
    static let caption1Bold = UIFont(name: "GeneralSans-Bold", size: 12)
    static let caption1SemiBold = UIFont(name: "GeneralSans-Semibold", size: 12)
    static let caption1Medium = UIFont(name: "GeneralSans-Medium", size: 12)
    static let caption2SemiBold = UIFont(name: "GeneralSans-Semibold", size: 11)
    static let caption2Medium = UIFont(name: "GeneralSans-Medium", size: 11)
}
