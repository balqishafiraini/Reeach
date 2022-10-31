//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

class SetupPageView: UIViewController {
        
    let setupController = SetupController()
    var delegate: SetupDelegate!
    
    var content = UIView()
//    {
//        didSet {
//            print("didSet")
//            UIView.animate(withDuration: 0.5, animations: {
//                oldValue.alpha = 0
//            }) { _ in
//                oldValue.removeFromSuperview()
//                self.view.addSubview(self.content)
//            }
//        }
//    }
//
    let progressHeader: UIProgressView = {
        let view = UIProgressView(frame: CGRectZero)

        return view

    }()
    
//    let progressHeader: SetupProgressHeader = {
//        let view = SetupProgressHeader(frame: CGRectZero)
//
//        return view
//
//    }()
    
    let goalView: AddGoal = {
        let view = AddGoal(frame: CGRectZero)
        
        return view
    }()
    
    let incomeView: AddIncome = {
        let view = AddIncome(frame: CGRectZero)
        
        return view
    }()
    
    let budgetView: AddBudget = {
        let view = AddBudget(frame: CGRectZero)
        
        return view
    }()
    
    let bottomView: SetupBottomView = {
        let view = SetupBottomView(frame: CGRectZero)
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        setupContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomView.controller = setupController
        bottomView.viewDelegate = self
        
        incomeView.controller = setupController
        incomeView.viewDelegate = self
        
        budgetView.controller = setupController
        budgetView.viewDelegate = self
    }
    
    func setupContent() -> UIView {
        print("setupController.currentProgressIndex \(setupController.currentProgressIndex)")
        
        content.removeFromSuperview()
        
        if setupController.currentProgressIndex == 0.0 {
            return goalView
        } else if setupController.currentProgressIndex == 1.0 {
            return incomeView
        } else if setupController.currentProgressIndex == 2.0 {
            return budgetView
        }
        
        return UIView()
    }
    
    func setupContentView() {
        print(#function)
        content = setupContent()
        
        view.addSubview(progressHeader)
        
        // TODO: Ubah subview ini tiap lanjut ke tahap selanjutnya
        // Ini yg berubah tiap dia next, but how?
        view.addSubview(content)
        
        view.addSubview(bottomView)
        
        progressHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: content.topAnchor, right: view.rightAnchor,paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        content.anchor(top: progressHeader.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor, paddingTop: 16)
        
        bottomView.anchor(top: content.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
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

extension SetupPageView: SetupDelegate {
    func updateProgress(progress: Float, progressIndex: Float) {
        setupContentView()
        
        progressHeader.setProgress(progress, animated: true)
        print("update in setup \(progress)")
    }
    
    func previousProgress(progress: Float, progressIndex: Float) {
        setupContentView()
        progressHeader.setProgress(progress, animated: true)
        print("previous in setup")
    }
    
    
}
