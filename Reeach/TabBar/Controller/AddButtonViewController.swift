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
        addButtonView.closeButton.addTarget(self, action: #selector(doneButton), for: .touchUpInside)
        addButtonView.newTransaction.addTarget(self, action: #selector(goToNewTransaction), for: .touchUpInside)
        addButtonView.newGoal.addTarget(self, action: #selector(goToNewGoal), for: .touchUpInside)
    }
    
    @objc private func doneButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func goToNewGoal(sender: UIButton) {
        print("go to new goal")
    }
    
    @objc private func goToNewTransaction(sender: UIButton) {
        print("go to new transaction")
    }

}
