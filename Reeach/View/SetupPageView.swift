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
        print(#function)
        
        let progressHeader: UIView = {
            let view = SetupProgressHeader(frame: CGRectZero)
            
            return view
            
        }()
        
        let contentView: UIView = {
            let view = AddGoal(frame: CGRectZero)
//            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
            
            return view
        }()
        
        let bottomView: UIView = {
            let view = SetupBottomView(frame: CGRectZero)
            
            return view
        }()
        
        view.addSubview(progressHeader)
        view.addSubview(contentView) // Ini yg berubah tiap dia next
        view.addSubview(bottomView)
        
        progressHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: contentView.topAnchor, right: view.rightAnchor)
        
        contentView.anchor(top: progressHeader.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor)
        
        bottomView.anchor(top: contentView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
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
