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
    
    func goToAllTransactions() {
        let targetViewController = AllTransactionViewController()
        targetViewController.dismissDelegate = self
        targetViewController.modalPresentationStyle = .fullScreen
        targetViewController.modalTransitionStyle = .coverVertical
        present(targetViewController, animated: true)
    }
    
    func goToAllBudgets() {
        tabBarController?.selectedIndex = 3
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
        if collectionView == contentView.goalCollectionView {
            return goals.count
        }
        else if collectionView == contentView.transactionCollectionView {
            return transactions.count
        }
        else if collectionView == contentView.budgetCollectionView {
            return budgets.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.goalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleGoalCollectionViewCell.reuseIdentifier, for: indexPath) as! SimpleGoalCollectionViewCell
            
            let goal = goals[indexPath.item]
            
            cell.iconLabel.text = goal.icon
            cell.titleLabel.text = goal.name
            cell.dueDateLabel.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
            cell.targetAmountLabel.text = CurrencyHelper.getCurrency(from: goal.targetAmount)
            cell.progressView.setProgress(Float(goal.initialSaving(before: Date())/goal.targetAmount), animated: false)
            
            return cell
        }
        else if collectionView == contentView.transactionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionItemViewCell.identifier, for: indexPath) as! TransactionItemViewCell
            
            cell.containerLeftConstraint.constant = 0
            cell.containerRightConstraint.constant = 0
            cell.setupData(transaction: transactions[indexPath.item])
            cell.setupView()
            return cell
        }
        else if collectionView == contentView.budgetCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleBudgetCollectionViewCell.reuseIdentifier, for: indexPath) as! SimpleBudgetCollectionViewCell
            
            cell.budget = budgets[indexPath.item]
            cell.configureContent()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == contentView.goalCollectionView {
            return CGSize(width: 280, height: collectionView.frame.height)
        }
        else if collectionView == contentView.transactionCollectionView {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
        else if collectionView == contentView.budgetCollectionView {
            return CGSize(width: collectionView.frame.width, height: 68)
        }
        return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.goalCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath)! as? SimpleGoalCollectionViewCell {
                cell.isSelected = false
                
                let targetViewController = GoalsOverviewViewController()
                targetViewController.goal = goals[indexPath.item]
                targetViewController.modalPresentationStyle = .fullScreen
                targetViewController.modalTransitionStyle = .crossDissolve
                present(targetViewController, animated: true)
            }
        }
        else if collectionView == contentView.transactionCollectionView {
            let navigationController = UINavigationController()
            navigationController.navigationItem.largeTitleDisplayMode = .never
            navigationController.navigationBar.setValue(true, forKey: "hidesShadow")

            let targetViewController = TransactionModalViewController()
            targetViewController.budget = transactions[indexPath.item].budget
            targetViewController.transaction = transactions[indexPath.item]
            targetViewController.mode = .edit
            targetViewController.dismissDelegate = self
            targetViewController.modalPresentationStyle = .pageSheet

            navigationController.pushViewController(targetViewController, animated: true)

            self.present(navigationController, animated: true)
        }
        else if collectionView == contentView.budgetCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath)! as? SimpleBudgetCollectionViewCell {
                cell.isSelected = false
                
                let targetViewController = TransactionCategoryDetailViewController()
                targetViewController.budget = budgets[indexPath.item]
                targetViewController.dismissDelegate = self
                targetViewController.modalPresentationStyle = .fullScreen
                targetViewController.modalTransitionStyle = .crossDissolve
                present(targetViewController, animated: true)
            }
        }
    }
}
