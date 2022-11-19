//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 03/11/22.
//

import UIKit

class SetupPageView: UIView {
    
    weak var viewController: SetupPageViewController?
    
    var content = UIView()
    
    let progressHeader: SetupProgressHeader = {
        let view = SetupProgressHeader(frame: CGRectZero)

        return view

    }()
    
    let goalView = AddGoalViewController()
    
    let incomeView = AddIncomeViewController()
    
    let budgetView = AddBudgetViewController()
    
    let bottomView: SetupBottomView = {
        let view = SetupBottomView(frame: CGRectZero)
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    
    func configureView(viewController: SetupPageViewController){
        self.viewController = viewController
        
        bottomView.delegate = viewController

        goalView.delegate = viewController
        
        incomeView.delegate = viewController

        budgetView.delegate = viewController
        
        setupContentView()
    }
    
    func setupContent() -> UIView {
        content.removeFromSuperview()
        
        if viewController!.currentProgressIndex == 0.0 {
            return goalView.view
        } else if viewController!.currentProgressIndex == 1.0 {
            return incomeView.view
        } else if viewController!.currentProgressIndex == 2.0 {
            return budgetView.view
        }
        
        return UIView()
    }
    
    func setupContentView() {
        self.backgroundColor = .ghostWhite
        
        content = setupContent()
        
        self.addSubview(progressHeader)
        self.addSubview(content)
        self.addSubview(bottomView)
        
        progressHeader.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: content.topAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        content.anchor(top: progressHeader.bottomAnchor, left: self.leftAnchor, bottom: bottomView.topAnchor, right: self.rightAnchor, paddingTop: 16)
        
        bottomView.anchor(top: content.bottomAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
    }
    
}
