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
    
    private lazy var goalCollectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 12
        return collectionViewFlowLayout
    }()
    
    lazy var goalCollectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: goalCollectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SimpleGoalCollectionViewCell.self, forCellWithReuseIdentifier: SimpleGoalCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var transactionContainerView = UIView()
    
    private lazy var transactionVerticalStackViewContainerView =
    {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .secondary
        return view
    }()
    
    private lazy var transactionVerticalStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var transactionHeaderStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .firstBaseline
        return stackView
    }()
    
    lazy var transactionHeaderLabel = {
        let label = UILabel()
        label.text = "Transaksi Hari Ini"
        label.font = UIFont.title
        label.textColor = .ghostWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var transactionHeaderButton = {
        let button = UIButton()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.primary as Any,
            .font: UIFont.headline as Any
        ]
        button.setAttributedTitle(NSAttributedString(string: "Semua", attributes: attributes), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var todayDateLabel = {
        let label = UILabel()
        label.text = "Current Date"
        label.font = UIFont.bodyMedium
        label.textAlignment = .left
        label.textColor = .ghostWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emptyTransactionLabelContainerView = UIView()
    
    lazy var emptyTransactionLabel = {
        let label = UILabel()
        label.text = "Belum ada transaksi."
        label.font = UIFont.headline
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var transactionBlankView = {
        let view = UIView()
        view.anchor(height: 12)
        return view
    }()
    
    private lazy var transactionCollectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 8
        return collectionViewFlowLayout
    }()
    
    lazy var transactionCollectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: transactionCollectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(TransactionItemViewCell.self, forCellWithReuseIdentifier: TransactionItemViewCell.identifier)
        return collectionView
    }()
    
    lazy var budgetHeaderContainerView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    private lazy var budgetHeaderStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var budgetHeaderLabel = {
        let label = UILabel()
        label.text = "Budget Bulan Ini"
        label.font = UIFont.title
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var budgetHeaderButton = {
        let button = UIButton()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.secondary as Any,
            .font: UIFont.headline as Any
        ]
        button.setAttributedTitle(NSAttributedString(string: "Semua Budget", attributes: attributes), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var budgetCollectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 8
        return collectionViewFlowLayout
    }()
    
    lazy var budgetCollectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: budgetCollectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(SimpleBudgetCollectionViewCell.self, forCellWithReuseIdentifier: SimpleBudgetCollectionViewCell.reuseIdentifier)
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
    
    lazy var transactionCollectionViewHeightConstraint = transactionCollectionView.heightAnchor.constraint(equalToConstant: 200)
    lazy var budgetCollectionViewHeightConstraint = budgetCollectionView.heightAnchor.constraint(equalToConstant: 500)
    
    func configureView(viewController: DashboardViewController) {
        self.viewController = viewController
        backgroundColor = .secondary
        
        viewDelegate = viewController
        goalCollectionView.delegate = viewController
        goalCollectionView.dataSource = viewController
        transactionCollectionView.delegate = viewController
        transactionCollectionView.dataSource = viewController
        budgetCollectionView.delegate = viewController
        budgetCollectionView.dataSource = viewController
        scrollView.delegate = self
        
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureAutoLayout() {
        addSubview(blankView)
        blankView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 128)
        
        addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
        
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
        goalDetailContainerView.anchor(height: 128)
        
        goalDetailContainerView.addSubview(goalDetailStackView)
        goalDetailStackView.anchor(top: goalDetailContainerView.topAnchor, left: goalDetailContainerView.leftAnchor, bottom: goalDetailContainerView.bottomAnchor, right: goalDetailContainerView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        goalDetailContainerView.addSubview(goalCollectionView)
        goalCollectionView.anchor(top: goalDetailContainerView.topAnchor, left: goalDetailContainerView.leftAnchor, bottom: goalDetailContainerView.bottomAnchor, right: goalDetailContainerView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        goalDetailStackView.addArrangedSubview(UIView())
        goalDetailStackView.addArrangedSubview(emptyGoalLabel)
        goalDetailStackView.addArrangedSubview(emptyGoalButton)
        goalDetailStackView.addArrangedSubview(UIView())
        emptyGoalButton.widthAnchor.constraint(equalTo: goalDetailStackView.widthAnchor).isActive = true
        
        
        stackView.addArrangedSubview(transactionContainerView)
        transactionContainerView.addSubview(transactionVerticalStackViewContainerView)
        transactionVerticalStackViewContainerView.anchor(top: transactionContainerView.topAnchor, left: transactionContainerView.leftAnchor, bottom: transactionContainerView.bottomAnchor, right: transactionContainerView.rightAnchor, paddingTop: 28, paddingLeft: 20, paddingRight: 20)
        
        transactionVerticalStackViewContainerView.addSubview(transactionVerticalStackView)
        transactionVerticalStackView.anchor(top: transactionVerticalStackViewContainerView.topAnchor, left: transactionVerticalStackViewContainerView.leftAnchor, bottom: transactionVerticalStackViewContainerView.bottomAnchor, right: transactionVerticalStackViewContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
        transactionVerticalStackView.addArrangedSubview(transactionHeaderStackView)
        transactionVerticalStackView.addArrangedSubview(todayDateLabel)
        transactionVerticalStackView.addArrangedSubview(transactionBlankView)
        transactionVerticalStackView.addArrangedSubview(emptyTransactionLabelContainerView)
        
        transactionVerticalStackView.addArrangedSubview(transactionCollectionView)
        
        transactionHeaderStackView.addArrangedSubview(transactionHeaderLabel)
        transactionHeaderStackView.addArrangedSubview(transactionHeaderButton)
        
        emptyTransactionLabelContainerView.addSubview(emptyTransactionLabel)
        emptyTransactionLabel.anchor(top: emptyTransactionLabelContainerView.topAnchor, left: emptyTransactionLabelContainerView.leftAnchor, bottom: emptyTransactionLabelContainerView.bottomAnchor, right: emptyTransactionLabelContainerView.rightAnchor, paddingTop: 20, paddingBottom: 20)
        
        transactionCollectionViewHeightConstraint.isActive = true
        
        
        stackView.addArrangedSubview(budgetHeaderContainerView)
        budgetHeaderContainerView.addSubview(budgetHeaderStackView)
        budgetHeaderStackView.anchor(top: budgetHeaderContainerView.topAnchor, left: budgetHeaderContainerView.leftAnchor, bottom: budgetHeaderContainerView.bottomAnchor, right: budgetHeaderContainerView.rightAnchor, paddingTop: 28, paddingLeft: 20, paddingBottom: 16, paddingRight: 20)
        
        budgetHeaderStackView.addArrangedSubview(budgetHeaderLabel)
        budgetHeaderStackView.addArrangedSubview(budgetHeaderButton)
        
        stackView.addArrangedSubview(budgetCollectionView)
        budgetCollectionViewHeightConstraint.isActive = true
        
        
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
        transactionHeaderButton.addTarget(self, action: #selector(goToAllTransactions), for: .touchUpInside)
        budgetHeaderButton.addTarget(self, action: #selector(goToAllBudgets), for: .touchUpInside)
    }
    
    @objc func goToAllGoals(_ sender: UIButton) {
        viewDelegate?.goToAllGoals()
    }
    
    @objc func goToAllTransactions(_ sender: UIButton) {
        viewDelegate?.goToAllTransactions()
    }
    
    @objc func goToAllBudgets(_ sender: UIButton) {
        viewDelegate?.goToAllBudgets()
    }
    
    @objc func addGoal(_ sender: UIButton) {
        viewDelegate?.addGoal()
    }
    
    @objc func goToTipDetail(_ gestureRecognizer: UITapGestureRecognizer) {
        if let card = gestureRecognizer.view as? TipCardView {
            viewDelegate?.goToTipDetail(tip: card.tip ?? Tip.allTips[0])
        }
    }
}

extension DashboardView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) {
            [unowned self] in
            backgroundColor = scrollView.bounds.contains(markerView.frame) ? .secondary : .ghostWhite
        }
    }
}
