//
//  GoalAllocationViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class CategoryAllocationModalViewController: UIViewController {
    
    var type: String = "Needs"
    
    let categoryAllocationModalView = CategoryAllocationModalView()


    override func viewDidLoad() {
        super.viewDidLoad()
        categoryAllocationModalView.configureStackView()
        view = categoryAllocationModalView
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
