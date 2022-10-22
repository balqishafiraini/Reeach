//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

class SetupPageView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    
        print(#function)
        
        setupContentView()
    }
    
    func setupContentView() {
        let contentView: UIView = {
            let view = AddGoal(frame: CGRectZero)
            
            return view
        }()
        
        view.addSubview(contentView)
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
