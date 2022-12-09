//
//  AddButtonViewController.swift
//  Reeach
//
//  Created by Balqis on 05/12/22.
//

import UIKit

class AddButtonViewController: UIViewController {
    
    let addButtonView = AddButtonView()
    weak var dismissDelegate: DismissViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = addButtonView
        addButtonView.configureAutoLayout()
        addButtonView.closeButton.addTarget(self, action: #selector(doneButton), for: .touchUpInside)
        addButtonView.newTransaction.addTarget(self, action: #selector(goToNewTransaction), for: .touchUpInside)
        addButtonView.newGoal.addTarget(self, action: #selector(goToNewGoal), for: .touchUpInside)
    }
    
    @objc private func doneButton(sender: UIButton) {
        dismissDelegate?.viewDismissed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func goToNewGoal(sender: UIButton) {
        let targetViewController = GoalModalViewController()
        targetViewController.delegate = dismissDelegate
        targetViewController.modalPresentationStyle = .pageSheet
        targetViewController.mode = .add
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(targetViewController, animated: false)
    }
    
    @objc private func goToNewTransaction(sender: UIButton) {
        let targetViewController = TransactionModalViewController()
        targetViewController.dismissDelegate = dismissDelegate
        targetViewController.modalPresentationStyle = .pageSheet
        targetViewController.mode = .add
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(targetViewController, animated: false)
    }

}
