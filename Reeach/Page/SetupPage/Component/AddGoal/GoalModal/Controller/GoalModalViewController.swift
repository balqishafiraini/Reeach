//
//  GoalModalViewController.swift
//  Reeach
//
//  Created by Balqis on 26/10/22.
//

import UIKit

class GoalModalViewController: UIViewController {
    
    let goalModalView = GoalModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tambah Goal"
        
        goalModalView.configureStackView()
        view = goalModalView
        
        goalModalView.recommendButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        goalModalView.inflationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
        
        self.setNavigationBar()
        
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        print("Button clicked")
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





