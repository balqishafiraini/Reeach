//
//  InflationDetailViewController.swift
//  Reeach
//
//  Created by William Chrisandy on 31/10/22.
//

import UIKit

class InflationDetailViewController: UIViewController {

    var contentView = InflationDetailView()
    
    let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)
    let inflationYear = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationYear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.configureText(inflationRate: inflationRate, inflationYear: inflationYear)
    }
    
    override func loadView() {
        super.loadView()
        
        title = "Tentang Inflasi"
        view = contentView
        contentView.configureView(viewController: self)
    }
    
    
}
