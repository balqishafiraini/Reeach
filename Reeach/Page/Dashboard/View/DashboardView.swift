//
//  DashboardView.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class DashboardView: UIView {
    weak var viewDelegate: DashboardViewDelegate?
    weak var viewController: DashboardViewController?
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return UIScrollView()
    }()
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var dateContainerView = {
        let view = UIView()
        view.backgroundColor = .secondary
        return view
    }()
    
    lazy var greetingLabel = {
        let label = UILabel()
        label.text = DateFormatHelper.getGreeting(from: Date())
        label.font = UIFont.largeTitle
        label.textColor = .ghostWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel = {
        let label = UILabel()
        label.text = DateFormatHelper.getMonthAndYearString(from: Date())
        label.font = UIFont.headline
        label.textColor = .primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var markerView = UIView()
    
    private lazy var goalHeaderContainerView = {
        let view = UIView()
        view.layer.cornerRadius = 28
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    private lazy var goalHeaderStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var goalHeaderLabel = {
        let label = UILabel()
        label.text = "Goal"
        label.font = UIFont.title
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var goalHeaderButton = {
        let button = UIButton()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.secondary as Any,
            .font: UIFont.headline as Any
        ]
        button.setAttributedTitle(NSAttributedString(string: "Semua Goals", attributes: attributes), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var goalDetailContainerView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    private lazy var goalDetailStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var emptyGoalLabel = {
        let label = UILabel()
        label.text = "Kamu belum ada goal nih :("
        label.font = UIFont.bodyMedium
        label.textColor = .black7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emptyGoalButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Ayo buat goals!")
    
    private lazy var collectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 12
        return collectionViewFlowLayout
    }()
    
    lazy var collectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SimpleGoalCollectionViewCell.self, forCellWithReuseIdentifier: SimpleGoalCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var tipsHeaderContainerView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    lazy var tipsHeaderLabel = {
        let label = UILabel()
        label.text = "Rekomendasi & Tips"
        label.font = UIFont.title
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tipsDetailContainerView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    private lazy var tipsDetailStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var tipCards: [TipCardView] = []
    
    private lazy var blankView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    func configureView(viewController: DashboardViewController) {
        self.viewController = viewController
        backgroundColor = .secondary
        
        viewDelegate = viewController
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        scrollView.delegate = self
        
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureAutoLayout() {
        addSubview(blankView)
        blankView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 128)
        
        addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
        
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(dateContainerView)
        dateContainerView.addSubview(greetingLabel)
        dateContainerView.addSubview(dateLabel)
        
        greetingLabel.anchor(top: dateContainerView.topAnchor, left: dateContainerView.leftAnchor, bottom: dateLabel.topAnchor, right: dateContainerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 4, paddingRight: 20)
        dateLabel.anchor(left: dateContainerView.leftAnchor, bottom: dateContainerView.bottomAnchor, right: dateContainerView.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        stackView.addArrangedSubview(markerView)
        
        stackView.addArrangedSubview(goalHeaderContainerView)
        goalHeaderContainerView.addSubview(goalHeaderStackView)
        goalHeaderStackView.anchor(top: goalHeaderContainerView.topAnchor, left: goalHeaderContainerView.leftAnchor, bottom: goalHeaderContainerView.bottomAnchor, right: goalHeaderContainerView.rightAnchor, paddingTop: 28, paddingLeft: 20, paddingBottom: 12, paddingRight: 20)
        
        goalHeaderStackView.addArrangedSubview(goalHeaderLabel)
        goalHeaderStackView.addArrangedSubview(goalHeaderButton)
        
        stackView.addArrangedSubview(goalDetailContainerView)
        goalDetailContainerView.anchor(height: 108)
        
        goalDetailContainerView.addSubview(goalDetailStackView)
        goalDetailStackView.anchor(top: goalDetailContainerView.topAnchor, left: goalDetailContainerView.leftAnchor, bottom: goalDetailContainerView.bottomAnchor, right: goalDetailContainerView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        goalDetailContainerView.addSubview(collectionView)
        collectionView.anchor(top: goalDetailContainerView.topAnchor, left: goalDetailContainerView.leftAnchor, bottom: goalDetailContainerView.bottomAnchor, right: goalDetailContainerView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        goalDetailStackView.addArrangedSubview(UIView())
        goalDetailStackView.addArrangedSubview(emptyGoalLabel)
        goalDetailStackView.addArrangedSubview(emptyGoalButton)
        goalDetailStackView.addArrangedSubview(UIView())
        emptyGoalButton.widthAnchor.constraint(equalTo: goalDetailStackView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(tipsHeaderContainerView)
        tipsHeaderContainerView.addSubview(tipsHeaderLabel)
        tipsHeaderLabel.anchor(top: tipsHeaderContainerView.topAnchor, left: tipsHeaderContainerView.leftAnchor, bottom: tipsHeaderContainerView.bottomAnchor, right: tipsHeaderContainerView.rightAnchor, paddingTop: 28, paddingLeft: 20, paddingRight: 20)
        
        stackView.addArrangedSubview(tipsDetailContainerView)
        tipsDetailContainerView.addSubview(tipsDetailStackView)
        tipsDetailStackView.anchor(top: tipsDetailContainerView.topAnchor, left: tipsDetailContainerView.leftAnchor, bottom: tipsDetailContainerView.bottomAnchor, right: tipsDetailContainerView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 16, paddingRight: 20)
        
    }
    
    func configureTipCards(tips: [Tip]) {
        for tip in tips {
            let tipCard = TipCardView()
            tipCard.setTip(tip)
            tipCards.append(tipCard)
            tipsDetailStackView.addArrangedSubview(tipCard)
            tipCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToTipDetail)))
        }
    }
    
    func configureClickableTarget() {
        goalHeaderButton.addTarget(self, action: #selector(goToAllGoals), for: .touchUpInside)
        emptyGoalButton.addTarget(self, action: #selector(addGoal), for: .touchUpInside)
    }
    
    @objc func goToAllGoals(_ sender: UIButton) {
        viewDelegate?.goToAllGoals()
    }
    
    @objc func addGoal(_ sender: UIButton) {
        viewDelegate?.addGoal()
    }
    
    @objc func goToTipDetail(gestureRecognizer: UITapGestureRecognizer) {
        if let card = gestureRecognizer.view as? TipCardView {
            viewDelegate?.goToTipDetail(tip: card.tip ?? Tip.allTips[0])
        }
    }
}

extension DashboardView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backgroundColor = scrollView.bounds.contains(markerView.frame) ? .secondary : .ghostWhite
    }
}
