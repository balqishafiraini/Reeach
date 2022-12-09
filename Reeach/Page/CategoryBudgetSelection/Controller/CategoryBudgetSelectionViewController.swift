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
    
    var budgets: [String: [Budget]] = [:]
    
    var keys: [String] = []
    
    var forBudget: TransactionType = .expense
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func configureData() {
        if forBudget == .expense {
            keys = [
                "Kebutuhan Pokok",
                "Kebutuhan Non-Pokok",
                "Lainnya"
            ]
            budgets = [
                "Kebutuhan Pokok": dbHelper.getBudgets(on: Date(), type: "Need"),
                "Kebutuhan Non-Pokok": dbHelper.getBudgets(on: Date(), type: "Want"),
                "Lainnya": [],
            ]
        } else {
            keys = ["Goal"]
            budgets = [
                "Goal": dbHelper.getBudgets(on: Date(), type: "Goal")
            ]
        }
        
        configureView()
    }
    
    func configureView() {
        categoryBudgetView.setupView()
        categoryBudgetView.budgetList.reloadData()
    }
}

extension CategoryBudgetSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == keys.count - 1 && forBudget == .expense {
            return 1
        }
        return budgets[keys[section]]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.reuseIdentifier, for: indexPath) as! ChipCollectionViewCell
        
        var label = ""
        if indexPath.section == keys.count - 1 && forBudget == .expense {
            label = "Lainnya"
        } else {
            label = (budgets[keys[indexPath.section]]![indexPath.item].category?.name)!
        }
        cell.titleLabel.text = label
        cell.configureActiveView()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderGoalDetailCollectionReusableView
                
                cell.titleLabel.text = keys[indexPath.section]
                cell.titleLabelLeftAnchorConstraint.constant = 0
                cell.titleLabelRightAnchorConstraint.constant = 0
                cell.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
                
                return cell
            default:
                print("Nothing here")
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == keys.count - 1 && forBudget == .expense {
            selectedDelegate?.selectedItem(budget: nil)
        } else {
            selectedDelegate?.selectedItem(budget: budgets[keys[indexPath.section]]![indexPath.item])
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

}
