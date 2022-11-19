//
//  SetupPageView.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

class SetupPageViewController: UIViewController {
    
    let contentView = SetupPageView()
    
    var currentProgress: Float = 0.0
    var currentProgressIndex: Float = 0.0
    let totalProgress: Float = 2.0
    
    var goals: [Goal] = []
    
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
            contentView.bottomView.backButton.isHidden = true
            contentView.bottomView.shouldDisableNextButton(isEnabled: !goals.isEmpty)
        case 1.0:
            contentView.bottomView.shouldDisableNextButton(isEnabled: income > 0.0)
            contentView.bottomView.backButton.isHidden = false
            contentView.bottomView.backButton.setTitle("Balik ke Goal-Setting", for: .normal)
        case 2.0:
            var isEnabled = false
            isEnabled = goalBudgets.count == 3 || goalBudgets.count == goals.count
            isEnabled = isEnabled ? needBudgets.count > 0 : isEnabled
            
            contentView.bottomView.shouldDisableNextButton(isEnabled: isEnabled)
            contentView.bottomView.backButton.isHidden = false
            contentView.bottomView.backButton.setTitle("Kembali ke Pemasukan", for: .normal)
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
            self.dismiss(animated: true)
            
            UserDefaults.standard.setValue(true, forKey: DateFormatHelper.getShortMonthAndYearString(from: Date()))
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
