//
//  GoalModalViewController.swift
//  Reeach
//
//  Created by Balqis on 26/10/22.
//

import UIKit

class GoalModalViewController: UIViewController {
    
    let goalModalView = GoalModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalModalView.configureStackView()
        view = goalModalView
        
        goalModalView.recommendButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        goalModalView.inflationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        print("Button clicked")
    }
}





