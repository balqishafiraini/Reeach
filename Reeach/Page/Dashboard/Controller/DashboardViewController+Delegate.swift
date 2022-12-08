//
//  DashboardViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

extension DashboardViewController: DashboardViewDelegate {
    func goToAllGoals() {
        tabBarController?.selectedIndex = 1
    }
    
    func addGoal() {
        let targetViewController = SetupPageViewController()
        targetViewController.delegate = self
        targetViewController.modalPresentationStyle = .fullScreen
        present(targetViewController, animated: true)
    }
    
    func goToTipDetail(tip: Tip) {
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")

        let modalViewController = TipDetailViewController()
        modalViewController.tip = tip
        modalViewController.modalPresentationStyle = .formSheet
        navigationController.pushViewController(modalViewController, animated: true)
        
        present(navigationController, animated: true)
    }
}

extension DashboardViewController: DismissViewDelegate {
    var viewControllerTitle: String { "Dashboard" }
    
    func viewDismissed() {
        loadData()
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleGoalCollectionViewCell.reuseIdentifier, for: indexPath) as! SimpleGoalCollectionViewCell
        
        let goal = goals[indexPath.item]
        
        cell.iconLabel.text = goal.icon
        cell.titleLabel.text = goal.name
        cell.dueDateLabel.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
        cell.targetAmountLabel.text = CurrencyHelper.getCurrency(from: goal.targetAmount)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 280, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)! as? SimpleGoalCollectionViewCell {
            cell.isSelected = false
            
            let targetViewController = GoalsOverviewViewController()
            targetViewController.goal = goals[indexPath.item]
            targetViewController.modalPresentationStyle = .fullScreen
            targetViewController.modalTransitionStyle = .crossDissolve
            present(targetViewController, animated: true)
        }
    }
}
