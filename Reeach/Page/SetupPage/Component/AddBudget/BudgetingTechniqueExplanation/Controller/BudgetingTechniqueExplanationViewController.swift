//
//  BudgetingTechniqueExplanationViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class BudgetingTechniqueExplanationViewController: UIViewController {
    var contentView = BudgetingTechniqueExplanationView()
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureView(viewController: self)
    }
}
