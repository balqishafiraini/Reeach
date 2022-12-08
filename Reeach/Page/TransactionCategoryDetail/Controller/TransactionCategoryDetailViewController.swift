//
//  TransactionCategoryDetailViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TransactionCategoryDetailViewController: UIViewController {

    var transactionDetailView = TransactionCategoryDetailView()
    
    var category: Category?
    var budget: Budget?
    var transactions: [Transaction] = []
    var searchedTransaction: [Transaction] = []
    var searchText: String = ""
    var filteredTransaction: [Transaction] = []
    var separatedTransactions: [Date: [Transaction]] = [:]
    var sortedKeys: [Date] = []
    
    let dbHelper = DatabaseHelper.shared
    
    weak var dismissDelegate: DismissViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = transactionDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        transactionDetailView.delegate = self
        
        configureData()
    }
    
    func configureData() {
        separatedTransactions = [:]
        
        category = budget?.category
        
        transactions = dbHelper.getTransactions(of: budget!)
        
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
        
        print(separatedTransactions)
        
        updateView()
    }
    
    func configureFilteredData(startMonth: Date? = Date(), endMonth: Date? = Date(), type: String? = nil, categoryBudget: Category? = nil) {
        filteredTransaction = dbHelper.getTransactions(since: startMonth!, upTo: endMonth!, type: type, category: categoryBudget)
        transactions = filteredTransaction
        
        separatedTransactions = getSeparatedTransactions(transactions: filteredTransaction)
        
        updateView()
    }
    
    func updateView() {
        transactionDetailView.removeStack()
        transactionDetailView.setupData(category: category, budget: budget, transactions: separatedTransactions, sortedKeys: sortedKeys)
        transactionDetailView.setupView()
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
    
    func openFilterSheet() {
        
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let vc = TransactionFilterViewController()
        vc.delegate = self
        vc.budgetCategory = category
        vc.modalPresentationStyle = .pageSheet
        
        navigationController.pushViewController(vc, animated: true)
        
        self.present(navigationController, animated: true)
    }
}

extension TransactionCategoryDetailViewController: TransactionDelegate {
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
        dismiss(animated: true)
    }
    
    func filterTransaction(startMonth: Date?, endMonth: Date?, type: String?, budgetCategory: Category?) {
        configureFilteredData(startMonth: startMonth, endMonth: endMonth, type: type, categoryBudget: budgetCategory)
    }
    
    func openTransactionModal() {
        let navigationController = UINavigationController()
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let vc = AddNewTransactionModalViewController()
        if let budget = budget {
            vc.budget = budget
        }
        vc.dismissDelegate = self
        vc.modalPresentationStyle = .pageSheet
        
        navigationController.pushViewController(vc, animated: true)
        
        self.present(navigationController, animated: true)
    }
}

extension TransactionCategoryDetailViewController: DismissViewDelegate {
    func viewDismissed() {
        self.configureData()
    }
}
