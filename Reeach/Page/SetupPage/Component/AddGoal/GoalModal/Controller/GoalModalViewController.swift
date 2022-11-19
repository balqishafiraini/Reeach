//
//  GoalModalViewController.swift
//  Reeach
//
//  Created by Balqis on 26/10/22.
//

import UIKit

class GoalModalViewController: UIViewController {
    
    enum EditMode {
           case add
           case edit
       }
    
    weak var delegate: DismissViewDelegate?
    var mode: EditMode = .add
    var goal: Goal?
    let goalModalView = GoalModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mode == .add ? "Tambah Goal" : "Edit Goal"
        if mode == .add {
            goal = DatabaseHelper.shared.createGoals(name: "Unnamed Goals", icon: "", dueDate: Date(), targetAmount: 0, timeTerm: "Unknown")
        }
        else if let goal, mode == .edit {
            goalModalView.iconView.iconTextField.text = goal.icon
            goalModalView.goalName.textField.text = goal.name
            goalModalView.dueDate.date = goal.dueDate
            goalModalView.dueDate.textField.textField.text = DateFormatHelper.getShortMonthAndYearString(from: goal.dueDate ?? Date())
            goalModalView.total.textField.text = DoubleToStringHelper.getString(from: goal.targetAmount)
            goalModalView.goalType.textField.text = "\(goal.timeTerm ?? "Unknown")-term"
            goalModalView.switchView.tf.textField.text = DoubleToStringHelper.getString(from: goal.initialSaving(before: Date()))
        }
        goalModalView.textFieldsIsNotEmpty(goalModalView.total.textField)
    }
    
    override func loadView() {
        super.loadView()
        goalModalView.configureStackView(viewController: self)
        view = goalModalView
    }
    
    func dismissView() {
        delegate?.viewDismissed()
        self.dismiss(animated: true, completion: nil)
    }
    
}

