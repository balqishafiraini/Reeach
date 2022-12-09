//
//  AddNewTransactionModelViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 06/12/22.
//

import UIKit

class AddNewTransactionModalViewController: UIViewController {

    lazy var addTransactionModalView = AddNewTransactionModalView()
    
    weak var dismissDelegate: DismissViewDelegate?
    
    let dbHelper = DatabaseHelper.shared
    
    var budget: Budget?
    
    enum Mode {
        case add
        case edit
    }
    
    var transaction: Transaction? = nil
    var mode: Mode = .add
    var delegate: TransactionDelegate?
    var transactionType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = addTransactionModalView
        addTransactionModalView.delegate = self
        addTransactionModalView.filterDelegate = self
        
        setNavigationBar()
        
        configureData()
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
        
        addTransactionModalView.budget = budget
        
        configureView()
    }
    
    func configureView() {
        addTransactionModalView.setupData()
        addTransactionModalView.setupView()
        addTransactionModalView.transactionBudgetCategory.isHidden = transactionType.isEmpty
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    @objc func saveTransaction() {
        let view = addTransactionModalView
        
        let icon = view.iconPicker.iconTextField.text
        let name = view.transactionName.textField.text
        let amount = view.income
        let date = view.transactionDate.date
        
        if mode == .add {
            if let _ = icon, let name = name, let date = date, let budget = budget {
                print("Transaksi normal")
                let _ = dbHelper.createTransaction(name: name, date: date, budget: budget, amount: amount, notes: "Hmm kok ga ada buat masukkin notes ya")
            } else {
                print("Transaksi lainnya")
                let _ = dbHelper.createTransaction(name: name ?? "Name", date: date ?? Date(), amount: amount, notes: "Hmm kok ga ada buat masukkin notes ya")
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
