//
//  TipDetailViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class TipDetailViewController: UIViewController {
    var tip: Tip?
    var contentView = TipDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        
        contentView.imageView.image = tip?.image
        contentView.titleLabel.text = tip?.explanationHeader
        contentView.descriptionLabel.text = tip?.explanationDetail
    }
    
    override func loadView() {
        super.loadView()
        title = tip?.title
        view = contentView
        contentView.configureView(viewController: self)
    }
}
