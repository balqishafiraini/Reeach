//
//  TransactionProtocol.swift
//  Reeach
//
//  Created by James Christian Wira on 01/12/22.
//

import Foundation

protocol TransactionDelegate: AnyObject {
    func openSheet()
    
    func search(searchText: String)
    
    func dismiss()
    
    func filterTransaction(startMonth: Date?, endMonth: Date?, type: String?, budgetCategory: Category?)
    
    func openTransactionModal(transaction: Transaction?)
}
