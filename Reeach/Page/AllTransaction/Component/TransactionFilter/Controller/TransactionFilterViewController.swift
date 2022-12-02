//
//  TransactionFilterViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TransactionFilterViewController: UIViewController {

    var filter = TransactionFilterView()
    weak var delegate: TransactionDelegate?
    
    var startDate: Date?
    var endDate: Date?
    var transactionType: String?
    var budgetCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = filter
        setNavigationBar()
        
        filter.controller = self
        filter.delegate = self
        filter.setupView()
    }
    
    func setNavigationBar() {
        self.title = "Filter Transaksi"
        let doneItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        doneItem.setTitleTextAttributes(attributes, for: .normal)
        
        navigationItem.leftBarButtonItem = doneItem
        navigationController?.navigationBar.backgroundColor = .ghostWhite
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        filter.dismissKeyboard()
        super.touchesBegan(touches, with: event)
        
    }
}
