//
//  TrackerEmptyStateViewController.swift
//  Reeach
//
//  Created by Balqis on 10/11/22.
//

import UIKit

class TrackerEmptyStateViewController: UIViewController {
    
    let trackerEmptyStateView = TrackerEmptyStateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = trackerEmptyStateView
        trackerEmptyStateView.configureAutoLayout()
    }

}
