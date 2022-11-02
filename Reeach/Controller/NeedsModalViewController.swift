//
//  NeedsModalViewController.swift
//  Reeach
//
//  Created by Balqis on 02/11/22.
//

import UIKit

class NeedsModalViewController: UIViewController {
    
    let needsModalView = NeedsModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        needsModalView.configureStackView()
        view = needsModalView
    }
}
