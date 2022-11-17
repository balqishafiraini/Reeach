//
//  GoalAllocationModalViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class GoalAllocationModalViewController: UIViewController {
    
    enum EditMode {
        case add
        case edit
    }
    
    weak var delegate: GoalAllocationModalViewControllerDelegate?
    
    var mode: EditMode = .add
    
    let goalAllocationModalView = GoalAllocationModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalAllocationModalView.monthlySaving.textField.delegate = self
        
        goalAllocationModalView.configureStackView()
        view = goalAllocationModalView
        title = "Alokasi Goal"
        self.setNavigationBar()
        
        self.hideKeyboardWhenTappedAround()
        setupAddTargetIsNotEmptyTextFields()
        
        goalAllocationModalView.target.textField.keyboardType = .numberPad
        goalAllocationModalView.monthlySaving.textField.keyboardType = .numberPad
        
    }
    
    override func loadView() {
        super.loadView()
        
        if mode == .add {
            goalAllocationModalView.deleteButton.isHidden = true
        } else {
            goalAllocationModalView.deleteButton.isHidden = false
        }
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
    
    func setupAddTargetIsNotEmptyTextFields() {
        goalAllocationModalView.saveButton.isEnabled = false
        [goalAllocationModalView.monthlySaving.textField].forEach({ $0.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged) })
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
                
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard let saving = goalAllocationModalView.monthlySaving.textField.text, !saving.isEmpty
        else {
            goalAllocationModalView.saveButton.isEnabled = false
            return
        }
        goalAllocationModalView.saveButton.backgroundColor = .tangerineYellow
        goalAllocationModalView.saveButton.setTitleColor(UIColor.black13, for: .normal)
        
        goalAllocationModalView.saveButton.isEnabled = true
    }
    
    @objc func dismissView(){
        delegate?.viewDismissed()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension GoalAllocationModalViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        goalAllocationModalView.scrollView.setContentOffset(CGPoint.init(x: 0, y: UIScreen.main.bounds.height/3), animated: true)
    }
    private func textFieldDidEndEditing(textField: UITextField!) {
        goalAllocationModalView.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        
        self.view.endEditing(true);
    }
}



