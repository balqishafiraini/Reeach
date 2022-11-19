//
//  AddGoalViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 15/11/22.
//

import UIKit

class AddGoalViewController: UIViewController {

    weak var delegate: SetupPageViewController?
    
    var addGoal: AddGoal = AddGoal(frame: .zero)
    
    var goals: [Goal] = []
    var isFirstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGoal.delegate = delegate
        addGoal.controller = self
        
        self.view = addGoal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupData() {
        goals = DatabaseHelper().getGoals()
        
        addGoal.goals = goals
        delegate?.goals = goals
        delegate?.setDisableButton()
        addGoal.setupView()
        addGoal.goalList.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isFirstTime = false
    }
}

extension AddGoalViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension AddGoalViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        goals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalItemCollectionViewCell.identifier, for: indexPath) as! GoalItemCollectionViewCell
        
        cell.title = goals[indexPath.row].name
        cell.dueDate = goals[indexPath.row].dueDate
        cell.iconName = goals[indexPath.row].icon
        cell.amount = goals[indexPath.row].targetAmount
        
        cell.configureData()
        
        cell.setNeedsLayout()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 88)
    }
}

extension AddGoalViewController: DismissViewDelegate {
    func viewDismissed() {
        setupData()
    }
}
