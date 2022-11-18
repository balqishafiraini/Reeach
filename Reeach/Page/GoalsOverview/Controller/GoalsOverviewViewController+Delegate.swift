//
//  GoalsOverviewViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 18/11/22.
//

import UIKit

extension GoalsOverviewViewController: GoalsOverviewViewDelegate {
    func back() {
        dismiss(animated: true)
    }
    
    func goToEditMode() {
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let targetViewController = GoalModalViewController()
        targetViewController.delegate = self
        targetViewController.modalPresentationStyle = .pageSheet
        targetViewController.mode = .edit
        targetViewController.goal = goal
        
        navigationController.pushViewController(targetViewController, animated: true)
        self.present(navigationController, animated: true)
    }
}

extension GoalsOverviewViewController: DismissViewDelegate {
    func viewDismissed() {
        updateContent()
    }
}
