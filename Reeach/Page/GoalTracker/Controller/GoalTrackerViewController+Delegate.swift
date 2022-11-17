//
//  GoalTrackerViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import UIKit

extension GoalTrackerViewController: GoalTrackerViewDelegate {
    func goToBudgetPlanner() {
        let targetViewController = SetupPageViewController()
        targetViewController.modalPresentationStyle = .fullScreen
        present(targetViewController, animated: true)
    }
    
    func addGoal() {
        let targetViewController = GoalModalViewController()
        targetViewController.modalPresentationStyle = .formSheet
        // TODO: Pasang Delegate
        present(targetViewController, animated: true)
    }
    
    func changeGoalStatusData(_ status: String) {
        if status == "Active" {
            goals = Goal.categorizeGoals(goals: DatabaseHelper().getAllocatedGoals(on: Date()))
            contentView.titleExplanationLabel.text = "Semua goals yang kamu budget bulan ini."
        }
        else if status == "Inactive" {
            goals = Goal.categorizeGoals(goals: DatabaseHelper().getUnallocatedGoals(on: Date()))
            contentView.titleExplanationLabel.text = "Semua goals yang tidak kamu budget bulan ini."
        }
        
        terms.removeAll()
        for goal in goals {
            terms.append(goal[0].timeTerm ?? "Unknown Term")
        }
        
        contentView.emptyStateContainerView.isHidden = goals.isEmpty ? false : true
        contentView.collectionView.reloadData()
    }
}

extension GoalTrackerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return terms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 124)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCardCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCardCollectionViewCell
        
        let goal = goals[indexPath.section][indexPath.item]
        
        cell.contentView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        cell.category = goal
        cell.configureContent()
        
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
        if let cell = collectionView.cellForItem(at: indexPath)! as? CategoryCardCollectionViewCell {
            // TODO: Pindah view ke goal overview
            cell.isSelected = false
        }
    }
}