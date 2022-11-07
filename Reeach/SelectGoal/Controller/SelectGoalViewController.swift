//
//  SelectGoalViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

class SelectGoalViewController: UIViewController {
    let goals = DatabaseHelper().getUnallocatedGoals(on: Date())
    
    var contentView = SelectGoalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        title = "Pilih Goal"
        view = contentView
        contentView.configureView(viewController: self)
    }
}
