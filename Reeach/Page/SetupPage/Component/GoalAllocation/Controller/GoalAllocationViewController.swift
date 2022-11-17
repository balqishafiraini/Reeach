//
//  GoalAllocationViewController.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import UIKit

class GoalAllocationViewController: UIViewController {
    
    let goalAllocationView = GoalAllocationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalAllocationView.configureStackView()
        view = goalAllocationView
        title = "Alokasi Goal"
        self.setNavigationBar()
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
