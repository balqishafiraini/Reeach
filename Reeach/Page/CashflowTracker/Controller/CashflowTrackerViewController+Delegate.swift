//
//  CashflowTrackerViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 02/12/22.
//

import UIKit

extension CashflowTrackerViewController: CashflowTrackerViewDelegate {
    func goToBudgetPlanner() {
        let targetViewController = SetupPageViewController()
        targetViewController.delegate = self
        targetViewController.modalPresentationStyle = .fullScreen
        present(targetViewController, animated: true)
    }
    
    func goToAllTransaction() {
        let targetViewController = AllTransactionViewController()
        targetViewController.dismissDelegate = self
        targetViewController.modalPresentationStyle = .fullScreen
        targetViewController.modalTransitionStyle = .coverVertical
        present(targetViewController, animated: true)
    }
    
    func changeMonth(next: Bool) {
        currentMonth = next ? DateFormatHelper.getStartDateOfNextMonth(of: currentMonth) : DateFormatHelper.getStartDateOfPreviousMonth(of: currentMonth)
        loadData()
    }
}

extension CashflowTrackerViewController: DismissViewDelegate {
    var viewControllerTitle: String { "Cashflow Tracker" }
    
    func viewDismissed() {
        loadData()
    }
}

extension CashflowTrackerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == contentView.transactionCollectionView {
            return 1
        }
        else if collectionView == contentView.budgetCollectionView {
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.transactionCollectionView {
            return todayTransactions.count
        }
        else if collectionView == contentView.budgetCollectionView {
            return section == 0 ? incomeBudget == nil ? 0 : 1 : budgets.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == contentView.transactionCollectionView {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
        else if collectionView == contentView.budgetCollectionView {
            return CGSize(width: collectionView.frame.width, height: indexPath.section == 0 ? 116 : 188)
        }
        return CGSize(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.transactionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionItemViewCell.identifier, for: indexPath) as! TransactionItemViewCell
            
            cell.containerLeftConstraint.constant = 0
            cell.containerRightConstraint.constant = 0
            cell.setupData(transaction: todayTransactions[indexPath.item])
            cell.setupView()
            return cell
        }
        else if collectionView == contentView.budgetCollectionView {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncomeCardCollectionViewCell.reuseIdentifier, for: indexPath) as! IncomeCardCollectionViewCell
                
                cell.budget = incomeBudget
                cell.configureContent()
                return cell
            }
            else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCardCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCardCollectionViewCell
                
                cell.budget = budgets[indexPath.item]
                cell.configureContent()
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == contentView.budgetCollectionView {
            return CGSize(width: collectionView.frame.width, height: 54)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == contentView.budgetCollectionView {
            if kind == UICollectionView.elementKindSectionHeader {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderGoalDetailCollectionReusableView
                
                cell.titleLabel.text = indexPath.section == 0 ? "Pemasukan" : "Kategori Budget"
                
                return cell
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.transactionCollectionView {
            // TODO: YOK PINDAH PAGE YOK
        }
        else if collectionView == contentView.budgetCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath)! as? CategoryCardCollectionViewCell {
                cell.isSelected = false
                
                if indexPath.section == 1 {
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
}
