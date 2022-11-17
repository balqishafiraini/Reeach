//
//  GoalsOverviewViewController.swift
//  Reeach
//
//  Created by Balqis on 15/11/22.
//

import UIKit

class GoalsOverviewViewController: UIViewController {
    
    let goalsOverviewView = GoalsOverviewView()

    override func viewDidLoad() {
        super.viewDidLoad()
        goalsOverviewView.configureAutoLayout()
        view = goalsOverviewView
    
    }
    
}
