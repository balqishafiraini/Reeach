//
//  AddNewTransactionModelViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 06/12/22.
//

import UIKit

class TransactionModalViewController: UIViewController {

    lazy var addTransactionModalView = AddNewTransactionModalView()
    
    weak var dismissDelegate: DismissViewDelegate?
    weak var delegate: TransactionDelegate?
    
    let dbHelper = DatabaseHelper.shared
    
    var budget: Budget?
    
    enum Mode {
        case add
        case edit
    }
    
    var transaction: Transaction? = nil
    var mode: Mode = .add
    var pressableSelector = true
    var transactionType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = addTransactionModalView
        addTransactionModalView.delegate = self
        addTransactionModalView.filterDelegate = self
        
        setNavigationBar()
        
        if mode == .edit || UserDefaults.standard.bool(forKey: DateFormatHelper.getShortMonthAndYearString(from: Date())) {
            addTransactionModalView.emptyStateContainerView.isHidden = true
            addTransactionModalView.scrollView.isHidden = false
        }
        else {
            addTransactionModalView.emptyStateContainerView.isHidden = false
            addTransactionModalView.scrollView.isHidden = true
            navigationItem.rightBarButtonItem = nil
        }
        configureData()
        shouldEnableSaveButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setNavigationBar() {
        self.title = mode == .add ? "Tambah Transaksi" : "Ubah Transaksi"
        let cancelButton = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))
        let saveButton = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(saveTransaction))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        cancelButton.setTitleTextAttributes(attributes, for: .normal)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.navigationBar.backgroundColor = .ghostWhite
    }
    
    func configureData() {
        if let transaction = transaction {
            addTransactionModalView.transaction = transaction
        }
        
        if let _ = budget {
            addTransactionModalView.budget = budget
            transactionType = TransactionType.expense.rawValue
            addTransactionModalView.transactionType.textField.text = transactionType
            addTransactionModalView.transactionType.textField.isEnabled = false
        }
        
        configureView()
    }
    
    func configureView() {
        addTransactionModalView.setupData()
        addTransactionModalView.setupView()
        shouldHideCategoryBudget()
        addTransactionModalView.setSelectorPressable(isPressable: pressableSelector)
    }
    
    func shouldHideCategoryBudget() {
        switch transactionType {
            case TransactionType.expense.rawValue:
                addTransactionModalView.transactionBudgetCategory.isHidden = false
                
            case TransactionType.goal.rawValue:
                addTransactionModalView.transactionBudgetCategory.isHidden = false
                
            default:
                addTransactionModalView.transactionBudgetCategory.isHidden = true
        }
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    @objc func saveTransaction() {
        let view = addTransactionModalView
        
        let icon = view.iconPicker.iconTextField.text
        let name = view.transactionName.textField.text
        let amount = view.income
        let date = view.date
        
        if mode == .add {
            if let _ = icon, let name = name, let budget = budget {
                let _ = dbHelper.createTransaction(name: name, date: date, budget: budget, amount: amount, notes: "")
            } else {
                let _ = dbHelper.createTransaction(name: name ?? "Name", date: date, amount: amount, notes: "")
            }
        } else {
            transaction?.name = name
            transaction?.amount = amount
            transaction?.date = date
            transaction?.budget = self.budget

            dbHelper.saveContext()
        }

        dismissDelegate?.viewDismissed()
        dismiss(animated: true)
    }
}
