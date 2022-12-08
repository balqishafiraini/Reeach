//
//  CategoryBudgetSelectionViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 08/12/22.
//

import UIKit

class CategoryBudgetSelectionViewController: UIViewController {

    lazy var categoryBudgetView = CategoryBudgetSelectionView()
    
    let dbHelper = DatabaseHelper.shared
    
    var budgets: [Budget] = []
    
    weak var selectedDelegate: SelectCategoryBudgetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = categoryBudgetView
        categoryBudgetView.budgetList.delegate = self
        categoryBudgetView.budgetList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureData()
    }

    func configureData() {
        budgets = dbHelper.getExpenseBudgets(on: Date())
//        budgets = dbHelper.getBudgets()
        
        configureView()
    }
    
    func configureView() {
        categoryBudgetView.setupView()
        categoryBudgetView.budgetList.reloadData()
    }
}

extension CategoryBudgetSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return budgets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.reuseIdentifier, for: indexPath) as! ChipCollectionViewCell
        
        cell.titleLabel.text = budgets[indexPath.item].category?.name
        cell.configureActiveView()
        cell.sizeToFit()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDelegate?.selectedItem(budget: budgets[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        let width = self.estimatedFrame(text: (budgets[indexPath.item].category?.name)!, font: .bodyMedium!.withSize(16)).width
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 40.0)
    }
}

extension CategoryBudgetSelectionViewController {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = "Title"
//        let width = self.estimatedFrame(text: text, font: UIFont.systemFont(ofSize: 14)).width
//        return CGSize(width: width, height: 50.0)
//    }

    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
}
