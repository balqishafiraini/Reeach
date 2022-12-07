//
//  DashboardViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class DashboardViewController: UIViewController {
    var goals: [Goal] = []
    var transactions: [Transaction] = []
    var budgets: [Budget] = []
    
    let tips = Tip.allTips
    
    var contentView = DashboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        contentView.greetingLabel.text = DateFormatHelper.getGreeting(from: Date())
        
        let isSet = UserDefaults.standard.bool(forKey: DateFormatHelper.getShortMonthAndYearString(from: Date()))
        
        if isSet {
            contentView.emptyGoalButton.isHidden = true
            contentView.emptyGoalLabel.isHidden = true
            contentView.goalCollectionView.isHidden = false
            contentView.budgetHeaderContainerView.isHidden = false
            contentView.budgetCollectionView.isHidden = false
        }
        else {
            contentView.emptyGoalButton.isHidden = false
            contentView.emptyGoalLabel.isHidden = false
            contentView.goalCollectionView.isHidden = true
            contentView.budgetHeaderContainerView.isHidden = true
            contentView.budgetCollectionView.isHidden = true
        }
        
        let databaseHelper = DatabaseHelper.shared
        goals = databaseHelper.getAllocatedGoals(on: Date())
        contentView.goalCollectionView.reloadData()
        
        
        contentView.todayDateLabel.text = DateFormatHelper.getDDddMMyyy(from: Date())
        
        transactions = databaseHelper.getTodayTransactions()
        if transactions.isEmpty {
            contentView.emptyTransactionLabelContainerView.isHidden = false
            contentView.transactionBlankView.isHidden = true
            contentView.transactionCollectionView.isHidden = true
        }
        else {
            contentView.emptyTransactionLabelContainerView.isHidden = true
            contentView.transactionBlankView.isHidden = false
            contentView.transactionCollectionView.isHidden = false
        }
        
        contentView.transactionCollectionViewHeightConstraint.constant = CGFloat(transactions.count * 60)
        if transactions.count >= 2 {
            contentView.transactionCollectionViewHeightConstraint.constant += 8.0
        }
        contentView.transactionCollectionView.reloadData()
        
        
        budgets = Array(databaseHelper.getExpenseBudgets(on: Date()).prefix(3))
        
        if budgets.isEmpty {
            contentView.budgetHeaderContainerView.isHidden = true
            contentView.budgetCollectionView.isHidden = true
        }
        else {
            contentView.budgetHeaderContainerView.isHidden = false
            contentView.budgetCollectionView.isHidden = false
        }
        
        contentView.budgetCollectionViewHeightConstraint.constant = CGFloat(budgets.count * 68)
        if budgets.count >= 2 {
            contentView.budgetCollectionViewHeightConstraint.constant += CGFloat(Double(budgets.count-1) * 8.0)
        }
        contentView.budgetCollectionView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureTipCards(tips: tips)
        contentView.configureView(viewController: self)
    }
}
