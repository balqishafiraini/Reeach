//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 03/11/22.
//

import UIKit

class SetupPageView: UIView {
    
    var viewController: SetupPageViewController? = nil
    
    var content = UIView()
    
    let progressHeader: SetupProgressHeader = {
        let view = SetupProgressHeader(frame: CGRectZero)

        return view

    }()
    
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
    
    func configureView(viewController: SetupPageViewController){
        self.viewController = viewController
        
        bottomView.controller = viewController
        bottomView.viewDelegate = self
        bottomView.progressDelegate = progressHeader

        incomeView.controller = viewController
        incomeView.viewDelegate = self
        incomeView.progressDelegate = progressHeader
        incomeView.bottomDelegate = bottomView

        budgetView.controller = viewController
        budgetView.viewDelegate = self
        budgetView.progressDelegate = progressHeader
        budgetView.bottomDelegate = bottomView
        
        setupContentView()
    }
    
    func setupContent() -> UIView {
        content.removeFromSuperview()
        
        if viewController!.currentProgressIndex == 0.0 {
            return goalView
        } else if viewController!.currentProgressIndex == 1.0 {
            return incomeView
        } else if viewController!.currentProgressIndex == 2.0 {
            return budgetView
        }
        
        return UIView()
    }
    
    func setupContentView() {
        self.backgroundColor = .white
        
        content = setupContent()
        
        self.addSubview(progressHeader)
        self.addSubview(content)
        self.addSubview(bottomView)
        
        progressHeader.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: content.topAnchor, right: self.rightAnchor,paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        content.anchor(top: progressHeader.bottomAnchor, left: self.leftAnchor, bottom: bottomView.topAnchor, right: self.rightAnchor, paddingTop: 16)
        
        bottomView.anchor(top: content.bottomAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor)
    }
    
}

extension SetupPageView: SetupDelegate {
    func updateProgress(progress: Float, progressIndex: Float) {
        setupContentView()
    }
    
//    func previousProgress(progress: Float, progressIndex: Float) {
//        setupContentView()
//    }
}
