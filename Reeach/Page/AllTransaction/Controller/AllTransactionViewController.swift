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

        self.view = allTransactionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureData()
        
        allTransactionView.transactionList.delegate = self
        allTransactionView.transactionList.dataSource = self
        allTransactionView.delegate = self
        allTransactionView.searchBar.delegate = self
        allTransactionView.setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.dismissKeyboard()
        allTransactionView.dismissKeyboard()
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
        
        allTransactionView.emptyView.isHidden = !separatedTransactions.isEmpty
        allTransactionView.transactionList.isHidden = separatedTransactions.isEmpty
        
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
        allTransactionView.setupView()
        allTransactionView.transactionList.reloadData()
    }
    
    func getSeparatedTransactions(transactions: [Transaction]) -> [Date: [Transaction]] {
        var newTransaction: [Date: [Transaction]] = [:]
        
        for transaction in transactions {
            let key = DateFormatHelper.getStartDate(of: transaction.date!)
            if newTransaction[key] != nil {
                newTransaction[key]?.append(transaction)
            } else {
                newTransaction[key] = [transaction]
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

