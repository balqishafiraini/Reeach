//
//  AllTransactionViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 30/11/22.
//

import UIKit

class AllTransactionViewController: UIViewController {

    lazy var allTransactionView = AllTransactionView()
    
    let databaseHelper = DatabaseHelper.shared
    
    var transactions: [Transaction] = []
    var searchedTransaction: [Transaction] = []
    var filteredTransaction: [Transaction] = []
    var separatedTransactions: [Date: [Transaction]] = [:]
    var sortedKeys: [Date] = []
    var searchText: String = ""
    
    weak var dismissDelegate: DismissViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = allTransactionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureData()
        
        allTransactionView.transactionList.delegate = self
        allTransactionView.transactionList.dataSource = self
        allTransactionView.delegate = self
        allTransactionView.setupView()
    }
    
    func configureData() {
        transactions = []
        separatedTransactions = [:]
        sortedKeys = []
        
        transactions = databaseHelper.getTransactions(on: Date())
        
        separatedTransactions = getSeparatedTransactions(transactions: transactions)
        
        updateView()
    }
    
    func configureSearchData() {
        searchedTransaction = []
        separatedTransactions = [:]
        
        searchedTransaction = transactions.filter({ transaction in
            (transaction.name?.contains(searchText))!
        })
        
        separatedTransactions = getSeparatedTransactions(transactions: searchedTransaction)
        
        updateView()
    }
    
    func configureFilteredData(startMonth: Date? = Date(), endMonth: Date? = Date(), type: String? = nil, categoryBudget: Category? = nil) {
        var transactionType = ""
        if let type = type {
            switch type {
                case "Pengeluaran":
                    transactionType = "Expense"
                case "Pemasukan":
                    transactionType = "Income"
                default:
                    transactionType = "Goal"
            }
        }
        filteredTransaction = databaseHelper.getTransactions(since: startMonth!, upTo: endMonth!, type: transactionType, category: categoryBudget)
        
        separatedTransactions = getSeparatedTransactions(transactions: filteredTransaction)
        
        updateView()
    }
    
    func updateView() {
        allTransactionView.transactions = separatedTransactions
        allTransactionView.transactionList.reloadData()
    }
    
    func getSeparatedTransactions(transactions: [Transaction]) -> [Date: [Transaction]] {
        var newTransaction: [Date: [Transaction]] = [:]
        
        for transaction in transactions {
            if newTransaction[transaction.date!] != nil {
                newTransaction[transaction.date!]?.append(transaction)
            } else {
                newTransaction[transaction.date!] = [transaction]
            }
        }
        
        sortedKeys = (newTransaction.keys).sorted { date1, date2 in
            date1 > date2
        }
        
        return newTransaction
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func openFilterSheet() {
        
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let vc = TransactionFilterViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        
        navigationController.pushViewController(vc, animated: true)
        
        self.present(navigationController, animated: true)
    }
}

extension AllTransactionViewController: TransactionDelegate {
    func openSheet() {
        openFilterSheet()
    }
    
    func search(searchText: String) {
        self.searchText = searchText
        
        if searchText.isEmpty {
            configureData()
        } else {
            configureSearchData()
        }
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


extension AllTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
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
