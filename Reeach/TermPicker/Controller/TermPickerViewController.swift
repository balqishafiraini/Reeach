//
//  TermPickerViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 02/11/22.
//

import UIKit

class TermPickerViewController: UIViewController {
    let terms = ["Short", "Medium", "Long"]
    var contentView = TermPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        title = "Jangka Waktu"
        view = contentView
        contentView.configureView(viewController: self)
    }

}
