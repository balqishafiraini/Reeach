//
//  BudgetView.swift
//  Reeach
//
//  Created by James Christian Wira on 07/11/22.
//

import UIKit

class BudgetView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var labelText: String
    var type: String // Goal, Need, Want
    
    init(frame: CGRect, labelText: String, type: String){
        self.labelText = labelText
        self.type = type
        
        super.init(frame: frame)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        self.labelText = "Implement label here"
        self.type = "Goal"
        
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: SetupDelegate?
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = .bodyBold
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
            
        label.textColor = .accentGreen7
        label.font = .caption1Bold
        
        return label
    }()
    
    lazy var addButton: Button = {
        let button = Button(style: .rounded, foreground: .destructive, background: .royalHunterBlue, title: "Tambah Kebutuhan Baru")
        
        return button
    }()
    
    func setupView() {
        label.text = labelText
        
        self.addSubview(label)
        self.addSubview(statusLabel)
        self.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(openGoalSelection), for: .touchUpInside)
        
        setupStatusLabel()
    }
    
    func setupStatusLabel(budgets: [Budget]? = []){
//        let hasGoal = !budgets!.isEmpty // TODO: Need value from controller
        let hasGoal = true
        
        removeConstraints(statusLabel.constraints)
        removeConstraints(label.constraints)
        removeConstraints(addButton.constraints)
        
        if hasGoal {
            // TODO: Benerin nih itungan
            var allocation: Double = 2500000
            for budget in budgets!{
                allocation += budget.monthlyAllocation
            }
            
            let percetage = allocation / 10000000.0
            
            label.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: statusLabel.topAnchor, right: self.rightAnchor, paddingBottom: 4)
            statusLabel.anchor(top: label.bottomAnchor, left: self.leftAnchor, bottom: addButton.topAnchor, right: self.rightAnchor, paddingTop: 4, paddingBottom: 12)
            addButton.anchor(top: statusLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 12)
            
            if percetage < 0.2 {
                statusLabel.text = "Halah mana ini"
                statusLabel.textColor = .red7
                

            } else {
                statusLabel.text = "Keren, alokasi ini sudah mencapai \(percetage * 100)%"
                statusLabel.textColor = .accentGreen7
                
            }
        } else {
            statusLabel.isHidden = true
            
            label.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: addButton.topAnchor, right: self.rightAnchor, paddingBottom: 12)
            addButton.anchor(top: label.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 12)
        }
    }
    
    @objc func openGoalSelection() {
        // TODO: Coba tambahin goal ke controller disini
        
        print("\(#function) for \(type)")
        
//        let newBudget = Budget()
//        newBudget.monthlyAllocation = 2500000
//
//        delegate?.addBudget!(type: type, budget: newBudget)
    }
}
