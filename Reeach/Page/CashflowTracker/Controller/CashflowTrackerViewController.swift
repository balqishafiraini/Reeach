//
//  CashflowTrackerViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 02/12/22.
//

import UIKit

class CashflowTrackerViewController: UIViewController {
    var incomeBudget: Budget?
    var budgets: [Budget] = []
    var currentMonth = DateFormatHelper.getStartDateOfMonth(of: Date())
    var contentView = CashflowTrackerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        contentView.monthLabel.text = DateFormatHelper.getMonthAndYearString(from: currentMonth)
        
        let isCurrentMonth = DateFormatHelper.getStartDateOfMonth(of: currentMonth) == DateFormatHelper.getStartDateOfMonth(of: Date())
        contentView.rightButton.isEnabled = !isCurrentMonth
        
        let isSet = UserDefaults.standard.bool(forKey: DateFormatHelper.getShortMonthAndYearString(from: currentMonth))
        
        let databaseHelper = DatabaseHelper.shared
        budgets = databaseHelper.getExpenseBudgets(on: currentMonth)
        
        let incomeCategory = databaseHelper.getCategory(name: "Income")!
        incomeBudget = databaseHelper.getBudget(on: currentMonth, of: incomeCategory)
        
        if isSet {
            contentView.emptyStateContainerView.isHidden = true
            contentView.scrollView.isHidden = false
        }
        else {
            contentView.emptyStateContainerView.isHidden = false
            contentView.scrollView.isHidden = true
            
            contentView.emptyDescriptionLabel.text = isCurrentMonth ? "Kamu belum memiliki rencana budget nih. Yuk buat sekarang!" : "Kamu tidak memiliki rencana budget pada bulan ini."
            contentView.emptyGoalButton.isHidden = !isCurrentMonth
        }
        contentView.collectionViewHeightConstraint.constant = CGFloat(224 + budgets.count * 200)
        contentView.collectionView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
        contentView.configureView(viewController: self)
    }
}
