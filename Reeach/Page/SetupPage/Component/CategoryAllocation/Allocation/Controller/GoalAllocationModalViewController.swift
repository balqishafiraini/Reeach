//
//  GoalAllocationViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class GoalAllocationModalViewController: UIViewController {
    
    var type: String = "Needs"
    
    let goalAllocationModalView = GoalAllocationModalView()


    override func viewDidLoad() {
        super.viewDidLoad()
        goalAllocationModalView.configureStackView()
        view = goalAllocationModalView
        self.setNavigationBar()
    }
    
    override func loadView() {
        super.loadView()
        title = type == "Needs" ? "Kebutuhan Pokok" : "Kebutuhan Non-Pokok"
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
