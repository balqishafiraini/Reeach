//
//  Card.swift
//  Reeach
//
//  Created by Balqis on 23/10/22.
//

import Foundation
import UIKit

class Card: UIView {
    
    let boxView: UIView = {
       let box = UIView()
        box.layer.cornerRadius = 16
        box.backgroundColor = UIColor(named: "secondary7")
        return box
    }()
}
