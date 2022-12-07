//
//  AddButtonViewController.swift
//  Reeach
//
//  Created by Balqis on 05/12/22.
//

import UIKit

class AddButtonViewController: UIViewController {
    
    let addButtonView = AddButtonView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = addButtonView
        addButtonView.configureAutoLayout()
        addButtonView.closeButton.addTarget(self, action: #selector(doneButton), for: .touchCancel)
        
    }
    
    @objc private func doneButton(sender: UIButton) {
        print("close")
    }

}
