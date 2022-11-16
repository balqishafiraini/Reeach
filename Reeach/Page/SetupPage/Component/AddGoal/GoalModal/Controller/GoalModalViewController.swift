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
        
        goalModalView.goalType.textField.delegate = self
        goalModalView.total.textField.delegate = self
        goalModalView.switchView.tf.textField.delegate = self
        goalModalView.iconView.iconTextField.delegate = self
        
        goalModalView.total.textField.keyboardType = .numberPad
        goalModalView.switchView.tf.textField.keyboardType = .numberPad
            
        goalModalView.recommendButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        goalModalView.inflationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        goalModalView.saveButton.addTarget(self, action: #selector(saveGoalToCoreData), for: .touchUpInside)
        
        //add target edit button
        goalModalView.iconView.editButton.addTarget(self, action: #selector(editIconTapped), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
        
        self.setNavigationBar()
        
        // Jangan lupa diapus
        let goals: [Goal] = DatabaseHelper().getGoals()
        print(goals.count)
    }
    
    @objc func saveGoalToCoreData() {
        let amount = Double(goalModalView.total.textField.text ?? "0.0")
        let initSaving = Double(goalModalView.switchView.tf.textField.text ?? "0.0")
        
        self.saveInput(iconName: goalModalView.iconView.iconTextField.text ?? "iphone", goal: goalModalView.goalName.textField.text, deadline: goalModalView.dueDate.date, amount: amount, goalType: goalModalView.goalType.textField.text, initSaving: initSaving)
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        print(#function)
    }
    
    @objc func editIconTapped(_ sender: UIButton!) {
        goalModalView.iconView.iconTextField.isUserInteractionEnabled = true
        goalModalView.iconView.iconTextField.becomeFirstResponder()
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

extension GoalModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == goalModalView.goalType.textField {
            return false
        }
        
        if textField == goalModalView.iconView.iconTextField {
            let maxLength = 1
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)

            return newString.count <= maxLength
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == goalModalView.goalType.textField {
            let goalVC = TermPickerViewController()
            navigationController?.pushViewController(goalVC, animated: true)
        } else {
            goalModalView.scrollView.setContentOffset(CGPoint.init(x: 0, y: UIScreen.main.bounds.height/3), animated: true)
        }
    }
    
    private func textFieldDidEndEditing(textField: UITextField!) {
        goalModalView.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)

        self.view.endEditing(true);
    }
    
    
}
