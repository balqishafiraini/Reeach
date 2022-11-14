//
//  SelectBudgetCategory+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

extension SelectBudgetCategoryViewController: NavigationBarDelegate {
    func cancel() {
        navigationController?.popViewController(animated: true)
    }
}

extension SelectBudgetCategoryViewController: SelectBudgetCategoryViewDelegate {
    func addCategory() {
        let targetViewController = AddCategoryViewController()
        targetViewController.category = DatabaseHelper().createCategory(name: "Unnamed Category", type: type, icon: "")
        navigationController?.pushViewController(targetViewController, animated: true)
    }
}

extension SelectBudgetCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! GoalDetailCollectionViewCell
        
        cell.titleLabel.isHidden = true
        
        let category = categories[indexPath.item]
        cell.iconLabel.text = category.icon
        cell.detailLabel.text = category.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)! as? GoalDetailCollectionViewCell {
            cell.configureSelectedView()
            cell.isSelected = false
            delegate?.selected(category: categories[indexPath.item])
            navigationController?.popViewController(animated: true)
        }
    }
}
