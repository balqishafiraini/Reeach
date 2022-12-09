//
//  AllTransactionViewController+Delegate.swift
//  Reeach
//
//  Created by James Christian Wira on 09/12/22.
//

import UIKit

extension AllTransactionViewController: TransactionDelegate {
    func openSheet() {
        openFilterSheet()
    }
    
    func search(searchText: String) {
        print("Nothing to do here")
    }
    
    func dismiss() {
        dismissDelegate?.viewDismissed()
        self.dismiss(animated: true)
    }
    
    func filterTransaction(startMonth: Date?, endMonth: Date?, type: String?, budgetCategory: Category?) {
        configureFilteredData(startMonth: startMonth, endMonth: endMonth, type: type, categoryBudget: budgetCategory)
    }
    
    func openTransactionModal(transaction: Transaction?) {
        print("Nothing to do here")
    }
}

extension AllTransactionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        
        if searchText.isEmpty {
            configureData()
        } else {
            configureSearchData()
        }
    }
}

extension AllTransactionViewController: DismissViewDelegate {
    func viewDismissed() {
        configureData()
    }
}

extension AllTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let targetViewController = TransactionModalViewController()
        targetViewController.budget = separatedTransactions[sortedKeys[indexPath.section]]![indexPath.item].budget
        targetViewController.transaction = separatedTransactions[sortedKeys[indexPath.section]]![indexPath.item]
        targetViewController.mode = .edit
        targetViewController.dismissDelegate = self
        targetViewController.modalPresentationStyle = .pageSheet
        
        navigationController.pushViewController(targetViewController, animated: true)
        
        self.present(navigationController, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sortedKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.separatedTransactions[self.sortedKeys[section]]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allTransactionView.transactionList.dequeueReusableCell(withReuseIdentifier: TransactionItemViewCell.identifier, for: indexPath) as! TransactionItemViewCell
        
        cell.setupData(transaction: self.separatedTransactions[sortedKeys[indexPath.section]]![indexPath.item])
        cell.setupView()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderGoalDetailCollectionReusableView
                
                let dateString = DateFormatHelper.getDDddMMyyy(from: sortedKeys[indexPath.section])
                cell.titleLabel.text = dateString
                
                return cell
            default:
                print("Nothing here")
            
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
