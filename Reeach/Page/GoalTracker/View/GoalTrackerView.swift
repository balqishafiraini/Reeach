//
//  GoalTrackerView.swift
//  Reeach
//
//  Created by William Chrisandy on 15/11/22.
//

import UIKit

class GoalTrackerView: UIView {
    weak var viewDelegate: GoalTrackerViewDelegate?
    weak var viewController: GoalTrackerViewController?
    
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
        imageView.image = UIImage(named: "IllustrationGoal")
        return imageView
    }()
    
    private lazy var emptyDescriptionContainerView = UIView()
    
    lazy var emptyDescriptionLabel = {
        let label = UILabel()
        label.text = "Tahu gak sih, bikin goals itu langkah pertama untuk financial planning lho."
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black7
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emptyGoalButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Ayo buat goals!")
    
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
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Daftar Goals Kamu"
        label.font = UIFont.largeTitle
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var goalTermContainerView = UIView()
    
    lazy var goalTermStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var activeButton = {
        var chip = ChipCollectionViewCell()
        chip.titleLabel.text = "Aktif"
        chip.setIsActive(.active)
        chip.anchor(height: 38)
        return chip
    }()
    
    lazy var inActiveButton = {
        var chip = ChipCollectionViewCell()
        chip.titleLabel.text = "Tidak Aktif"
        chip.anchor(height: 38)
        return chip
    }()
    
    lazy var titleExplanationLabel = {
        let label = UILabel()
        label.text = "Semua goals yang udah kamu buat."
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addGoalButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Tambah Goal")
    
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
        collectionView.register(CategoryCardCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCardCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderGoalDetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var bottomBlankContainerView = {
        let view = UIView()
        view.anchor(height: 12)
        return view
    }()
    
    lazy var centerYEmptyContainerViewConstraint = emptyStateContainerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
    
    func configureView(viewController: GoalTrackerViewController) {
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
        rootStackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: bottomAnchor, right: viewMargins.rightAnchor)
        
        rootStackView.addArrangedSubview(headerContainerView)
        rootStackView.setCustomSpacing(12, after: headerContainerView)
        
        headerContainerView.addSubview(headerStackView)
        headerStackView.anchor(top: headerContainerView.topAnchor, left: headerContainerView.leftAnchor, bottom: headerContainerView.bottomAnchor, right: headerContainerView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 20)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.setCustomSpacing(4, after: titleLabel)
        headerStackView.addArrangedSubview(goalTermContainerView)
        headerStackView.addArrangedSubview(titleExplanationLabel)
        headerStackView.addArrangedSubview(addGoalButton)
        headerStackView.setCustomSpacing(16, after: titleExplanationLabel)
        
        goalTermContainerView.addSubview(goalTermStackView)
        goalTermStackView.anchor(top: goalTermContainerView.topAnchor, left: goalTermContainerView.leftAnchor, bottom: goalTermContainerView.bottomAnchor, right: goalTermContainerView.rightAnchor, paddingTop: 8, paddingBottom: 16)
        goalTermStackView.addArrangedSubview(activeButton)
        goalTermStackView.addArrangedSubview(inActiveButton)
        goalTermStackView.addArrangedSubview(UIView())
        
        rootStackView.addArrangedSubview(collectionView)
        rootStackView.addArrangedSubview(UIView())
        rootStackView.addArrangedSubview(bottomBlankContainerView)
        
        
        addSubview(emptyStateContainerView)
        emptyStateContainerView.anchor(left: viewMargins.leftAnchor, right: viewMargins.rightAnchor, paddingLeft: 20, paddingRight: 20)
        centerYEmptyContainerViewConstraint.isActive = true
        
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
    }
    
    func configureClickableTarget() {
        emptyGoalButton.addTarget(self, action: #selector(goToBudgetPlanner), for: .touchUpInside)
        activeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGoalStatus)))
        inActiveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGoalStatus)))
        addGoalButton.addTarget(self, action: #selector(addGoal), for: .touchUpInside)
    }
    
    @objc func goToBudgetPlanner(_ sender: UIButton) {
        viewDelegate?.goToBudgetPlanner()
    }
    
    @objc func addGoal(_ sender: UIButton) {
        viewDelegate?.addGoal()
    }
    
    @objc func changeGoalStatus(_ gestureRecognizer: UITapGestureRecognizer) {
        activeButton.setIsActive(gestureRecognizer.view == activeButton ? .active : .inactive)
        inActiveButton.setIsActive(gestureRecognizer.view == activeButton ? .inactive : .active)
        viewDelegate?.changeGoalStatusData(gestureRecognizer.view == activeButton ? "Active" : "Inactive")
    }
}
