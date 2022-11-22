//
//  SelectBudgetCategoryViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class SelectBudgetCategoryViewController: UIViewController {
    var type: String = "Need"
    var categories: [Category] = []
    weak var delegate: SelectBudgetCategoryViewControllerDelegate?
    var contentView = SelectBudgetCategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categories = DatabaseHelper.shared.getUnallocatedCategories(on: Date(), type: type)
        contentView.collectionView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        title = "Pilih Kategori"
        view = contentView
        contentView.configureView(viewController: self)
    }
}
