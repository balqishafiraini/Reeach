//
//  GoalAllocationModalViewController+Delegate.swift
//  Reeach
//
//  Created by William Chrisandy on 19/11/22.
//

import UIKit

extension GoalAllocationModalViewController: NavigationBarDelegate {
    func cancel() {
        let databaseHelper = DatabaseHelper.shared
        databaseHelper.rollbackContext()
        if let budget, mode == .add {
            let _ = databaseHelper.delete(budget)
        }
        dismissView()
    }
}

extension GoalAllocationModalViewController: GoalAllocationModalViewDelegate {
    func goToInflationDetail() {
        let targetViewController = InflationDetailViewController()
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func save(dueDate: Date, targetAmount: Double, montlyAllocation: Double) {
        let databaseHelper = DatabaseHelper.shared
        
        if let goal {
            goal.dueDate = dueDate
            goal.targetAmount = targetAmount
            goal.updatedAt = Date()
            databaseHelper.saveContext()
        }
        
        if let budget {
            budget.monthlyAllocation = montlyAllocation
            databaseHelper.saveContext()
        }
        dismissView()
    }
    
    func delete() {
        let databaseHelper = DatabaseHelper.shared
        databaseHelper.rollbackContext()
        if let budget {
            let _ = databaseHelper.delete(budget)
        }
        dismissView()
    }
    
    func updateDynamicView() {
        guard let goal, let budget
        else { return }
        
        let targetAmount: Double = {
            guard let targetAmountString = goalAllocationModalView.targetAmountTextField.textField.text, targetAmountString != ""
            else { return 0 }
            return Double(targetAmountString) ?? 0
        }()
        goal.targetAmount = targetAmount
        
        let dueDate: Date = {
            guard let dueDate = goalAllocationModalView.dueDateDatePicker.date
            else { return goal.dueDate ?? Date() }
            return dueDate
        }()
        goal.dueDate = dueDate
        
        let monthlyAllocation: Double = {
            guard let monthlyAllocationString = goalAllocationModalView.monthlyAllocationTextField.textField.text, monthlyAllocationString != ""
            else { return 0 }
            return Double(monthlyAllocationString) ?? 0
        }()
        budget.monthlyAllocation = monthlyAllocation
        
        let blackBoldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black13 as Any,
            .font: UIFont.caption1Bold as Any
        ]
        
        let blueBoldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.secondary as Any,
            .font: UIFont.caption1Bold as Any
        ]
        
        let blackMediumAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black13 as Any,
            .font: UIFont.caption1Medium as Any
        ]
        
        let inflationAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Nilai setelah inflasi: ", attributes: blueBoldAttributes)
        inflationAttributedString.append(NSAttributedString(string: CurrencyHelper.getCurrency(from: goal.valueAfterInflation(from: DateFormatHelper.getStartDateOfMonth(of: Date()))), attributes: blackBoldAttributes))
        goalAllocationModalView.inflationButton.setAttributedTitle(inflationAttributedString, for: .normal)
        
        var remaining = maximumAllocation - monthlyAllocation
        if remaining < 0 {
            remaining = 0
        }
        let remainingAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Sisa anggaran yang harus dialokasikan: ", attributes: blackMediumAttributes)
        remainingAttributedString.append(NSAttributedString(string: CurrencyHelper.getCurrency(from: remaining), attributes: blackBoldAttributes))
        goalAllocationModalView.remainingLabel.attributedText = remainingAttributedString
        
        if monthlyAllocation > unallocatedIncome {
            goalAllocationModalView.recommendationVerticalStackViewContainerView.backgroundColor = .red1
            goalAllocationModalView.recommendationHeaderLabel.textColor = .red7
            goalAllocationModalView.recommendationDetailLabel.textColor = .red7
            
            let image = goalAllocationModalView.showHideButton.imageView?.image
            let newImage = (image == UIImage(named: "DownGreen") || image == UIImage(named: "DownRed")) ? UIImage(named: "DownRed") : UIImage(named: "UpRed")
            goalAllocationModalView.showHideButton.setImage(newImage, for: .normal)
            
            goalAllocationModalView.recommendationHeaderLabel.text = """
            OH TIDAKKK!
            
            Kamu besar pasak daripada tiang nih.
            """
            
            goalAllocationModalView.recommendationDetailLabel.text = """
            Penghasilan yang belum kamu alokasikan hanya \(CurrencyHelper.getCurrency(from: unallocatedIncome)) :(
            
            Worry not. Stay calm, stay slay. Ini ada beberapa rekomendasi yang bisa kamu ikuti untuk mencapai goalsmu:
            
            1. Naikkan penghasilanmu, atau
            2. Turunkan alokasi bulanan lainnya, atau
            3. Ubah alokasi bulanan goal ini.
            """
        }
        else if goal.isAchievable(of: budget) == false {
            goalAllocationModalView.recommendationVerticalStackViewContainerView.backgroundColor = .red1
            goalAllocationModalView.recommendationHeaderLabel.textColor = .red7
            goalAllocationModalView.recommendationDetailLabel.textColor = .red7
            
            let image = goalAllocationModalView.showHideButton.imageView?.image
            let newImage = (image == UIImage(named: "DownGreen") || image == UIImage(named: "DownRed")) ? UIImage(named: "DownRed") : UIImage(named: "UpRed")
            goalAllocationModalView.showHideButton.setImage(newImage, for: .normal)
            
            goalAllocationModalView.recommendationHeaderLabel.text = """
            YUK REVISI GOALSNYA YUK!
            
            Pake strategi ini goalsnya akan sulit kamu capai nih.
            """
            
            var recommendedDeadlineString = "selamanya"
            if let recommendedDeadline = goal.recommendedDeadline(of: budget) {
                recommendedDeadlineString = DateFormatHelper.getShortMonthAndYearString(from: recommendedDeadline)
            }
            
            var recommendedTargetAmountString = "infinity :(("
            if let recommendedTargetAmount = goal.targetAmount(of: budget) {
                recommendedTargetAmountString = CurrencyHelper.getCurrency(from: recommendedTargetAmount)
            }
            
            var recommendedMonthlyAllocationString = "infinity :(("
            if let recommendedMonthlyAllocation = goal.recommendedMonthlyAllocation(of: budget) {
                recommendedMonthlyAllocationString = CurrencyHelper.getCurrency(from: recommendedMonthlyAllocation)
            }
            
            goalAllocationModalView.recommendationDetailLabel.text = """
            Worry not. Stay calm, stay slay. Ini ada beberapa rekomendasi yang bisa kamu ikuti untuk mencapai goalsmu:

            1. Ubah deadline menjadi \(recommendedDeadlineString), atau
            2. Ubah jumlah tujuan menjadi \(recommendedTargetAmountString), atau
            3. Ubah alokasi bulanan menjadi \(recommendedMonthlyAllocationString)
            """
        }
        else {
            goalAllocationModalView.recommendationVerticalStackViewContainerView.backgroundColor = .accentGreen2
            goalAllocationModalView.recommendationHeaderLabel.textColor = .accentGreen9
            goalAllocationModalView.recommendationDetailLabel.textColor = .accentGreen9
            
            let image = goalAllocationModalView.showHideButton.imageView?.image
            let newImage = (image == UIImage(named: "DownGreen") || image == UIImage(named: "DownRed")) ? UIImage(named: "DownGreen") : UIImage(named: "UpGreen")
            goalAllocationModalView.showHideButton.setImage(newImage, for: .normal)
            
            goalAllocationModalView.recommendationHeaderLabel.text = """
            MANTAP BOSQUE!
            
            Kekejar juga, finally. Konsisten menabung yah habis ini.  Jangan kalap.  🙏🏻
            """
            
            goalAllocationModalView.recommendationDetailLabel.text = """
            Soalnya, kalo kamu tidak konsisten menabung di bulan-bulan berikutnya, bisa jadi gak kekejar nih :(
            
            Ohya, dalam memberikan rekomendasi strategi goals, Reeach menggunakan Lambert’s Function untuk memberikan rekomendasi strategi goal.
            """
        }
    }
    
    func disableButtonIfNotAchivable() {
        guard let goal, let budget
        else {
            goalAllocationModalView.saveButton.backgroundColor = .black4
            goalAllocationModalView.saveButton.setTitleColor(UIColor.black7, for: .normal)
            goalAllocationModalView.saveButton.isEnabled = false
            return
        }
        
        guard budget.monthlyAllocation <= unallocatedIncome
        else {
            goalAllocationModalView.saveButton.backgroundColor = .black4
            goalAllocationModalView.saveButton.setTitleColor(UIColor.black7, for: .normal)
            goalAllocationModalView.saveButton.isEnabled = false
            return
        }
        
        guard goal.isAchievable(of: budget)
        else {
            goalAllocationModalView.saveButton.backgroundColor = .black4
            goalAllocationModalView.saveButton.setTitleColor(UIColor.black7, for: .normal)
            goalAllocationModalView.saveButton.isEnabled = false
            return
        }
        
        goalAllocationModalView.saveButton.backgroundColor = .tangerineYellow
        goalAllocationModalView.saveButton.setTitleColor(UIColor.black13, for: .normal)
        goalAllocationModalView.saveButton.isEnabled = true
    }
}
