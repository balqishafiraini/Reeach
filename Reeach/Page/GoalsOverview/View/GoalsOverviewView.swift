//
//  GoalsOverviewView.swift
//  Reeach
//
//  Created by Balqis on 15/11/22.
//

import UIKit

class GoalsOverviewView: UIView {
    weak var viewDelegate: GoalsOverviewViewDelegate?
    weak var viewController: GoalsOverviewViewController?
    
    let headerView = HeaderView()
    
    let totalTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total"
        lbl.font = .caption1Medium
        lbl.textColor = .ghostWhite
        lbl.textAlignment = .center
        return lbl
    }()
    
    let amount: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rp66.000.000"
        lbl.font = .largeTitle
        lbl.textColor = .ghostWhite
        lbl.textAlignment = .center
        return lbl
    }()
    
    let messageLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Slaaay. Kalau kamu konsisten fix bisa tercapai nih goalsnya, bestie. 🥳"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .darkSlateGray
        label.font = .headline
        label.backgroundColor = .secondary2
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.paddingRight = 23.5
        label.paddingLeft = 23.5
        label.paddingTop = 20
        label.paddingBottom = 20
        return label
    }()
    
    let deadline: UILabel = {
        let lbl = UILabel()
        lbl.text = "Deadline"
        lbl.font = .bodyBold
        lbl.textColor = .darkSlateGray
        return lbl
    }()
    
    let deadlineView = DeadlineView()
    
    let status: UILabel = {
        let lbl = UILabel()
        lbl.text = "Status Saat Ini"
        lbl.font = .bodyBold
        lbl.textColor = .darkSlateGray
        return lbl
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    let statusView = StatusView()
    
    //scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var blankView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    func configureView(viewController: GoalsOverviewViewController) {
        self.viewController = viewController
        backgroundColor = .royalHunterBlue
        
        viewDelegate = viewController
        
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureAutoLayout() {
        
        addSubview(blankView)
        blankView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 300)
        
        self.addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, width: UIScreen.main.bounds.width)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        
        containerView.addSubview(headerView)
        headerView.setUp()
        headerView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor)

        containerView.addSubview(messageLabel)
        messageLabel.anchor(top: headerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: UIScreen.main.bounds.height*0.35, paddingLeft: 20, paddingRight: 20)

        containerView.addSubview(deadline)
        deadline.anchor(top: messageLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

        containerView.addSubview(deadlineView)
        deadlineView.setUp()
        deadlineView.anchor(top: deadline.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

        containerView.addSubview(status)
        status.anchor(top: deadlineView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 24, paddingLeft: 20, paddingRight: 20)

        containerView.addSubview(statusView)
        statusView.setUp()
        statusView.anchor(top: status.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

    }
    
    func configureClickableTarget() {
        headerView.editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        headerView.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back() {
        viewDelegate?.back()
    }
    
    @objc func edit() {
        viewDelegate?.goToEditMode()
    }
}
class HeaderView: UIView {
    
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .royalHunterBlue
        return bg
    }()
    
    let backButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.anchor(width: 28)
        return button
    }()
    
    let iconLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "🤡"
        lbl.font = lbl.font.withSize(50)
        lbl.textAlignment = .center
        return lbl
    }()

    let goalName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Asuransi"
        lbl.font = .title
        lbl.textColor = .ghostWhite
        lbl.textAlignment = .center
        return lbl
    }()
    
    let termLabel: PaddingLabel = {
        let lbl = PaddingLabel()
        lbl.text = "Medium-term"
        lbl.font = .caption2Medium
        lbl.textColor = .royalHunterBlue
        lbl.textAlignment = .center
        lbl.backgroundColor = .ghostWhite
        lbl.layer.cornerRadius = 10
        lbl.layer.masksToBounds = true
        lbl.paddingRight = 8
        lbl.paddingLeft = 8
        lbl.paddingTop = 4
        lbl.paddingBottom = 4
        return lbl
    }()


    let totalTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total"
        lbl.font = .caption1Medium
        lbl.textColor = .ghostWhite
        lbl.textAlignment = .center
        return lbl
    }()
    
    let amount: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rp66.000.000"
        lbl.font = .largeTitle
        lbl.textColor = .ghostWhite
        lbl.textAlignment = .center
        return lbl
    }()
    

    let editButton: UIButton = {
        let button = UIButton()
        button.tintColor = .tangerineYellow
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)
        let symbol = UIImage(systemName: "square.and.pencil", withConfiguration: config)
        button.setImage(symbol, for: .normal)
        return button
    }()
    
//    let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }()
    
    func setUp() {
        //auto-layout
                
        addSubview(background)
        background.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.4)
        
        addSubview(backButton)
        backButton.anchor(top: background.topAnchor, left: background.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        addSubview(iconLabel)
        iconLabel.anchor(top: backButton.bottomAnchor, paddingTop: 8)
        
        addSubview(goalName)
        goalName.centerX(inView: background)
        goalName.anchor(top: background.topAnchor, left: iconLabel.rightAnchor, paddingTop: UIScreen.main.bounds.height*0.1, paddingLeft: 10)
        
        addSubview(editButton)
        editButton.anchor(top: background.topAnchor, left: goalName.rightAnchor, paddingTop: UIScreen.main.bounds.height*0.1, paddingLeft: 10)

        addSubview(termLabel)
        termLabel.centerX(inView: goalName)
        termLabel.anchor(top: goalName.bottomAnchor, paddingTop: 8)
        
        addSubview(totalTitle)
        totalTitle.anchor(top: termLabel.bottomAnchor, left: background.leftAnchor, right: background.rightAnchor, paddingTop:20)
        
        addSubview(amount)
        amount.anchor(top: totalTitle.bottomAnchor, left: background.leftAnchor, right: background.rightAnchor)
        
        bringSubviewToFront(totalTitle)
        bringSubviewToFront(amount)
        bringSubviewToFront(iconLabel)
        bringSubviewToFront(termLabel)
        bringSubviewToFront(goalName)
    }
    
}

class DeadlineView: UIView {
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .cardColor
        bg.layer.cornerRadius = 16
        bg.layer.masksToBounds = true
        return bg
    }()
    
    let image: UIImageView = {
        let img = UIImageView()
        img.frame.size = CGSize(width: 66, height: 66)
        img.image = UIImage(named: "IllustrationDeadline")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let date: UILabel = {
        let lbl = UILabel()
        lbl.text = "02/2026"
        lbl.font = .bodyBold
        lbl.textColor = .darkSlateGray
        return lbl
    }()
    
    
    func setUp() {
        //auto-layout
        
        addSubview(background)
        background.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.2)
        
        bringSubviewToFront(image)
        bringSubviewToFront(date)
        
        addSubview(image)
        image.centerY(inView: background)
        image.anchor(top: background.topAnchor, left: background.leftAnchor, paddingTop: 16, paddingLeft: 16, width: 66, height: 66)
        
        addSubview(date)
        date.centerY(inView: background)
        date.anchor(top: background.topAnchor, left: image.leftAnchor, paddingTop: 30, paddingLeft: 100)
    }
    
}

class StatusView: UIView {
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .cardColor
        bg.layer.cornerRadius = 16
        bg.layer.masksToBounds = true
        return bg
    }()
    
    let image: UIImageView = {
        let img = UIImageView()
        img.frame.size = CGSize(width: 66, height: 66)
        img.image = UIImage(named: "IllustrationActive")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let date: UILabel = {
        let lbl = UILabel()
        lbl.text = "Goal Aktif"
        lbl.font = .bodyBold
        lbl.textColor = .darkSlateGray
        return lbl
    }()
    
    
    func setUp() {
        //auto-layout
        
        addSubview(background)
        background.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.2)
        
        bringSubviewToFront(image)
        bringSubviewToFront(date)
        
        addSubview(image)
        image.centerY(inView: background)
        image.anchor(top: background.topAnchor, left: background.leftAnchor, paddingTop: 16, paddingLeft: 16, width: 66, height: 66)
        
        addSubview(date)
        date.centerY(inView: background)
        date.anchor(top: background.topAnchor, left: image.leftAnchor, paddingTop: 30, paddingLeft: 100)
    }
}
