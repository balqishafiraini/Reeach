//
//  GoalModalViewController.swift
//  Reeach
//
//  Created by Balqis on 26/10/22.
//

import UIKit

protocol GoalSetupDelegate: AnyObject {
    func saveInput(iconName: String?, goal: String?, deadline: Date?, amount: Double?, goalType: String?, initSaving: Double?)
}

class GoalModalViewController: UIViewController {
    
    var iconName: String?
    var goal: String?
    var deadline: Date?
    var amount: Double?
    var goalType: String?
    var initSaving: Float?
    
    let goalModalView = GoalModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tambah Goal"
        
        goalModalView.configureStackView()
        view = goalModalView
        
        goalModalView.recommendButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        goalModalView.inflationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        goalModalView.saveButton.addTarget(self, action: #selector(saveGoalToCoreData), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
        
        self.setNavigationBar()
        
        // Jangan lupa diapus
        let goals: [Goal] = DatabaseHelper().getGoals()
        print(goals.count)
    }
    
    @objc func saveGoalToCoreData() {
        let amount = Double(goalModalView.total.textField.text ?? "0.0")
        let initSaving = Double(goalModalView.switchView.tf.textField.text ?? "0.0")
        
        self.saveInput(iconName: goalModalView.iconView.iconLabel.text ?? "iphone", goal: goalModalView.goalName.textField.text, deadline: goalModalView.dueDate.date, amount: amount, goalType: goalModalView.goalType.textField.text, initSaving: initSaving)
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        print(#function)
    }
    
    func setNavigationBar() {
       let doneItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))

       let attributes: [NSAttributedString.Key : Any] = [
           NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
           NSAttributedString.Key.font: UIFont.bodyMedium as Any
       ]

       doneItem.setTitleTextAttributes(attributes, for: .normal)

       navigationItem.leftBarButtonItem = doneItem
   }

   @objc func dismissView(){
       self.dismiss(animated: true, completion: nil)
   }

}

extension GoalModalViewController: GoalSetupDelegate {
    func saveInput(iconName: String?, goal: String?, deadline: Date?, amount: Double?, goalType: String?, initSaving: Double?) {
        print(#function)
        let databaseHelper = DatabaseHelper()
        let date = DateFormatHelper.getStartDateOfPreviousMonth(of: Date())
        let goal = databaseHelper.createGoals(name: goal ?? "", icon: iconName ?? "", dueDate: deadline ?? Date(), targetAmount: amount ?? 0.0, timeTerm: goalType ?? "")
        let budget = databaseHelper.createBudget(monthlyAllocation: initSaving ?? 0.0, period: date, category: goal)
        let _ = databaseHelper.createTransaction(name: "Initial Saving", date: date, budget: budget, amount: initSaving ?? 0.0, notes: "")
        
        self.dismissView()
    }
}

