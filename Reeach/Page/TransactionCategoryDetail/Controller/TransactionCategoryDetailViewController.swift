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
    
    var totalExpense = 0.0
    
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
                
        calculateData()
        
        updateView()
    }
    
    func calculateData() {
        totalExpense = 0.0
        
        for key in sortedKeys {
            for transaction in separatedTransactions[key]! {
              totalExpense += transaction.amount
            }
        }
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
        filteredTransaction = dbHelper.getTransactions(since: startMonth!, upTo: endMonth!, type: type, category: categoryBudget)
        transactions = filteredTransaction
        
        separatedTransactions = getSeparatedTransactions(transactions: filteredTransaction)
        
        updateView()
    }   
    
    func updateView() {
        transactionDetailView.removeStack()
        transactionDetailView.setupData(budget: budget, transactions: separatedTransactions, sortedKeys: sortedKeys, remainingAmount: budget!.monthlyAllocation - totalExpense, expenseAmount: totalExpense)
        transactionDetailView.setupView()
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
}
