//
//  TermPickerViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 02/11/22.
//

import UIKit

extension TermPickerViewController: NavigationBarDelegate {
    func cancel() {
        navigationController?.popViewController(animated: true)
    }
}


extension TermPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! GoalDetailCollectionViewCell
        cell.iconLabel.isHidden = true
        
        let term = terms[indexPath.item]
        
        cell.titleLabel.text = "\(term)-term"
        cell.detailLabel.text = "\(Goal.timeTermDictionary[term] ?? "Unknown")"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 68)
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
