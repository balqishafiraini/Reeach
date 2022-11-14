//
//  MonthlyPlanningViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 08/11/22.
//

import UIKit

class MonthlyPlanningViewController: UIViewController {

    let planningView = MonthlyPlanningView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = planningView
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
