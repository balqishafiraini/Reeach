//
//  AddCategoryViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class AddCategoryViewController: UIViewController {
    var type: String = "Need"
    var category: Category?
    var contentView = AddCategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        category = DatabaseHelper().createCategory(name: "Unnamed Category", type: type, icon: "")
    }
    
    override func loadView() {
        super.loadView()
        title = "Kategori Baru"
        view = contentView
        contentView.configureView(viewController: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        contentView.dismissKeyboard()
        super.touchesBegan(touches, with: event)
    }
}
