//
//  GoalRecommendationViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

extension GoalRecommendationViewController: NavigationBarDelegate {
    func cancel() {
        navigationController?.popViewController(animated: true)
    }
}

extension GoalRecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return terms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! GoalDetailCollectionViewCell
        
        let goal = goals[indexPath.section][indexPath.item]
        cell.contentView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cell.titleLabel.text = goal.name
        cell.detailLabel.text = goal.description
        cell.iconLabel.text = goal.icon
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderGoalDetailCollectionReusableView
            
            let term = terms[indexPath.section]
            cell.titleLabel.text = "\(term)-term"
            
            return cell
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)! as? GoalDetailCollectionViewCell {
            cell.configureSelectedView()
            cell.isSelected = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)! as? GoalDetailCollectionViewCell {
            cell.configureSelectedView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
