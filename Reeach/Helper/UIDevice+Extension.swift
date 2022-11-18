//
//  UIDevice+Extension.swift
//  Reeach
//
//  Created by Balqis on 18/11/22.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.count == 0 {
                return false
                
            }
            let bottom = UIApplication.shared.windows[0].safeAreaInsets.bottom
            return bottom > 0
        } else {
            return false
        }
    }
}
