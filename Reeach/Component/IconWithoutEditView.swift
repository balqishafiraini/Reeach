//
//  IconWithoutEditView.swift
//  Reeach
//
//  Created by William Chrisandy on 17/11/22.
//

import UIKit

class IconWithoutEditView: UIView {
    let iconLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Icon"
        label.textAlignment = .center
        label.textColor = .royalHunterBlue
        label.font = .bodyMedium
        label.backgroundColor = .secondary2
        label.layer.cornerRadius = 75
        label.layer.masksToBounds = true
        return label
    }()
    
    
    func setUp() {
        //auto-layout
        
        addSubview(iconLabel)
        
        iconLabel.centerX(inView: self)
        
        iconLabel.anchor(width: 150, height: 150)
    }

}
