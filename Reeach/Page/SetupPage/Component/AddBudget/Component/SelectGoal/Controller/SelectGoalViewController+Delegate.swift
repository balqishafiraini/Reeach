//
//  SelectGoalViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

extension SelectGoalViewController: NavigationBarDelegate {
    func cancel() {
        dismissViewDelegate?.viewDismissed()
        dismiss(animated: true)
    }
}

extension SelectGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! GoalDetailCollectionViewCell
        cell.iconLabel.isHidden = true
        cell.detailLabel.isHidden = true
        
        cell.titleLabel.text = "\(goals[indexPath.item].name ?? "Unnamed Goal")"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 46)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)! as? GoalDetailCollectionViewCell {
            cell.configureSelectedView()
            cell.isSelected = false
            
            let targetViewController = GoalAllocationModalViewController()
            targetViewController.delegate = dismissViewDelegate
            targetViewController.modalPresentationStyle = .pageSheet
            targetViewController.mode = .add
            targetViewController.goal = goals[indexPath.item]
            
            navigationController?.popViewController(animated: false)
            navigationController?.pushViewController(targetViewController, animated: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)! as? GoalDetailCollectionViewCell {
            cell.configureSelectedView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
