//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

protocol BudgetDelegate: AnyObject {
    func addBudget()
}

class SetupPageViewController: UIViewController {
    
    let contentView = SetupPageView()
    
    var currentProgress: Float = 0.0
    var currentProgressIndex: Float = 0.0
    let totalProgress: Float = 2.0
    
    var income: Double = 0.0
    
    var goalBudgets: [Budget] = []
    var needBudgets: [Budget] = []
    var wantBudgets: [Budget] = []
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        view = contentView
        contentView.configureView(viewController: self)
    }
    
    func updateView() {
        shouldDisableButton(progressIndex: currentProgressIndex)
        contentView.bottomView.setButtonTitle(progressIndex: currentProgressIndex)
        contentView.setupContentView()
        contentView.progressHeader.progressBar.setProgress(currentProgress, animated: true)
        contentView.progressHeader.updateSteps(currentIndex: currentProgressIndex)
    }
    
    func shouldDisableButton(progressIndex: Float? = nil){
        let index: Float = progressIndex ?? self.currentProgressIndex
        
        switch index {
        case 0.0:
            print("Disable goal if no goal available")
        case 1.0:
            if income == 0.0 {
                contentView.bottomView.nextButton.isEnabled = false
            } else {
                contentView.bottomView.nextButton.isEnabled = true
            }
        case 2.0:
            print("")
        default:
            contentView.bottomView.nextButton.isEnabled = true
        }
    }
    func showPopUpConfirm() {
        let alert = UIAlertController(title: "Yakin udah selesai?", message: "Coba cek deh. Ada yang kureng gak?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Batal",
                                      style: UIAlertAction.Style.destructive,
                                      handler: nil
        ))
        
        alert.addAction(UIAlertAction(title: "Lanjut", style: UIAlertAction.Style.default, handler: { _ in
            //TODO: Action lanjut
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
