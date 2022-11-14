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
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
