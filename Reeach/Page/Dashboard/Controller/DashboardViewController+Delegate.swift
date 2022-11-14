//
//  DashboardViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

extension DashboardViewController: DashboardViewProtocol {
    func goToAllGoals() {
        // TODO: SWITCH TAB TO TAB 2
    }
    
    func addGoal() {
        let targetViewController = SetupPageViewController()
        targetViewController.modalPresentationStyle = .fullScreen
        present(targetViewController, animated: true)
    }
    
    func goToTipDetail(tip: Tip) {
        let targetViewController = TipDetailViewController()
        targetViewController.tip = tip
        targetViewController.modalPresentationStyle = .pageSheet
        present(targetViewController, animated: true)
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
            // TODO: PRESENT FULL SCREEN GOAL OVERVIEW
            
            cell.isSelected = false
        }
    }
}
