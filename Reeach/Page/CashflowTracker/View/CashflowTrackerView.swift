//
//  CashflowTrackerView.swift
//  Reeach
//
//  Created by William Chrisandy on 02/12/22.
//

import UIKit

class CashflowTrackerView: UIView {
    weak var viewDelegate: CashflowTrackerViewDelegate?
    weak var viewController: CashflowTrackerViewController?
    
    lazy var emptyStateContainerView = UIView()
    
    private lazy var emptyStateStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var imageViewContainerView = UIView()
    
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 5/6).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "IllustrationNoBudget")
        return imageView
    }()
    
    private lazy var emptyDescriptionContainerView = UIView()
    
    lazy var emptyDescriptionLabel = {
        let label = UILabel()
        label.text = "Kamu belum memiliki rencana budget nih. Yuk buat sekarang!"
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black7
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emptyGoalButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Ayo buat rencana budget!")
    
    lazy var rootStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var headerContainerView = UIView()
    
    private lazy var headerStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Cashflow Tracker"
        label.font = UIFont.largeTitle
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var monthContainerView = UIView()
    
    lazy var monthStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var leftButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "LeftYellow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .secondary
        return button
    }()
    
    lazy var monthLabel = {
        let label = UILabel()
        label.text = "MMMM yyyy"
        label.font = UIFont.headline
        label.textColor = .secondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rightButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RightYellow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .secondary
        return button
    }()
    
    private lazy var scrollViewContainerView = UIView()
    
    lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return UIScrollView()
    }()
    
    private lazy var scrollAreaStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
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
        label.text = "Transaksi Terakhir"
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
    
    private lazy var emptyTransactionLabelContainerView = UIView()
    
    lazy var emptyTransactionLabel = {
        let label = UILabel()
        label.text = "Belum ada transaksi."
        label.font = UIFont.headline
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 12
        return collectionViewFlowLayout
    }()
    
    lazy var collectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(IncomeCardCollectionViewCell.self, forCellWithReuseIdentifier: IncomeCardCollectionViewCell.reuseIdentifier)
        collectionView.register(CategoryCardCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCardCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderGoalDetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var bottomBlankContainerView = {
        let view = UIView()
        view.anchor(height: 12)
        return view
    }()
    
    lazy var collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 500)
    
    func configureView(viewController: CashflowTrackerViewController) {
        self.viewController = viewController
        backgroundColor = .ghostWhite
        
        viewDelegate = viewController
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureAutoLayout() {
        let viewMargins = safeAreaLayoutGuide
        
        addSubview(rootStackView)
        rootStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor)
        
        rootStackView.addArrangedSubview(headerContainerView)
        rootStackView.addArrangedSubview(scrollViewContainerView)
        
        
        headerContainerView.addSubview(headerStackView)
        headerStackView.anchor(top: headerContainerView.topAnchor, left: headerContainerView.leftAnchor, bottom: headerContainerView.bottomAnchor, right: headerContainerView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 16, paddingRight: 20)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(monthContainerView)
        
        monthContainerView.addSubview(monthStackView)
        monthStackView.anchor(top: monthContainerView.topAnchor, bottom: monthContainerView.bottomAnchor)
        monthContainerView.widthAnchor.constraint(equalTo: monthStackView.widthAnchor).isActive = true
        monthStackView.centerX(inView: monthContainerView)
        monthStackView.addArrangedSubview(leftButton)
        monthStackView.addArrangedSubview(monthLabel)
        monthStackView.addArrangedSubview(rightButton)
        
        
        scrollViewContainerView.addSubview(scrollView)
        scrollView.anchor(top: scrollViewContainerView.topAnchor, left: scrollViewContainerView.leftAnchor, bottom: scrollViewContainerView.bottomAnchor, right: scrollViewContainerView.rightAnchor)
        
        scrollView.addSubview(scrollAreaStackView)
        scrollAreaStackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor)
        scrollAreaStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollAreaStackView.addArrangedSubview(transactionContainerView)
        scrollAreaStackView.addArrangedSubview(collectionView)
        scrollAreaStackView.addArrangedSubview(UIView())
        scrollAreaStackView.addArrangedSubview(bottomBlankContainerView)
        
        transactionContainerView.addSubview(transactionVerticalStackViewContainerView)
        transactionVerticalStackViewContainerView.anchor(top: transactionContainerView.topAnchor, left: transactionContainerView.leftAnchor, bottom: transactionContainerView.bottomAnchor, right: transactionContainerView.rightAnchor, paddingTop: 4, paddingLeft: 20, paddingRight: 20)
        
        transactionVerticalStackViewContainerView.addSubview(transactionVerticalStackView)
        transactionVerticalStackView.anchor(top: transactionVerticalStackViewContainerView.topAnchor, left: transactionVerticalStackViewContainerView.leftAnchor, bottom: transactionVerticalStackViewContainerView.bottomAnchor, right: transactionVerticalStackViewContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
        transactionVerticalStackView.addArrangedSubview(transactionHeaderStackView)
        transactionVerticalStackView.addArrangedSubview(emptyTransactionLabelContainerView)
        
        transactionHeaderStackView.addArrangedSubview(transactionHeaderLabel)
        transactionHeaderStackView.addArrangedSubview(transactionHeaderButton)
        
        
        emptyTransactionLabelContainerView.addSubview(emptyTransactionLabel)
        emptyTransactionLabel.anchor(top: emptyTransactionLabelContainerView.topAnchor, left: emptyTransactionLabelContainerView.leftAnchor, bottom: emptyTransactionLabelContainerView.bottomAnchor, right: emptyTransactionLabelContainerView.rightAnchor, paddingTop: 20, paddingBottom: 20)
        
        collectionViewHeightConstraint.isActive = true
        
        
        addSubview(emptyStateContainerView)
        emptyStateContainerView.anchor(left: viewMargins.leftAnchor, right: viewMargins.rightAnchor, paddingLeft: 20, paddingRight: 20)
        emptyStateContainerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 20).isActive = true
        
        emptyStateContainerView.addSubview(emptyStateStackView)
        emptyStateStackView.anchor(top: emptyStateContainerView.topAnchor, left: emptyStateContainerView.leftAnchor, bottom: emptyStateContainerView.bottomAnchor, right: emptyStateContainerView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        emptyStateStackView.addArrangedSubview(imageViewContainerView)
        emptyStateStackView.addArrangedSubview(emptyDescriptionContainerView)
        emptyStateStackView.addArrangedSubview(emptyGoalButton)
        
        imageViewContainerView.addSubview(imageView)
        imageView.center(inView: imageViewContainerView)
        imageViewContainerView.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: viewMargins.widthAnchor, multiplier: 0.75).isActive = true
        
        emptyDescriptionContainerView.addSubview(emptyDescriptionLabel)
        emptyDescriptionLabel.anchor(top: emptyDescriptionContainerView.topAnchor, left: emptyDescriptionContainerView.leftAnchor, bottom: emptyDescriptionContainerView.bottomAnchor, right: emptyDescriptionContainerView.rightAnchor, paddingBottom: 28)
        rightButton.isEnabled = false
    }
    
    func configureClickableTarget() {
        emptyGoalButton.addTarget(self, action: #selector(goToBudgetPlanner), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(changeMonth), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(changeMonth), for: .touchUpInside)
        transactionHeaderButton.addTarget(self, action: #selector(goToAllTransaction), for: .touchUpInside)
    }
    
    @objc func goToBudgetPlanner(_ sender: UIButton) {
        viewDelegate?.goToBudgetPlanner()
    }
    
    @objc func goToAllTransaction(_ sender: UIButton) {
        viewDelegate?.goToAllTransaction()
    }
    
    @objc func changeMonth(_ sender: UIButton) {
        viewDelegate?.changeMonth(next: sender == rightButton)
    }
}
