//
//  Toggle.swift
//  Reeach
//
//  Created by Balqis on 22/10/22.
//

import UIKit

class Toggle: UIView {
    
    let toggleSwitch = UISwitch()
    
    private func designToggle() {
        translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.onTintColor = .royalHunterBlue
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
        {
            if (sender.isOn == true){
                print("UISwitch state is now ON")
            }
            else{
                print("UISwitch state is now Off")
            }
        }
    
}

