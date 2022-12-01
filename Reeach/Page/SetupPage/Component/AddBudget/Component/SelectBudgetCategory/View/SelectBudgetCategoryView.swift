//
//  SelectBudgetCategoryView.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class SelectBudgetCategoryView: UIView {
    weak var viewDelegate: SelectBudgetCategoryViewDelegate?
    weak var viewController: SelectBudgetCategoryViewController?
    weak var navigationBarDelegate: NavigationBarDelegate?
    var isShown: Bool = false
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var containerView = UIView()
    
    lazy var addCategoryButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Buat kategori baru")
    
    private lazy var collectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 14
        return collectionViewFlowLayout
    }()
    
    lazy var collectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(GoalDetailCollectionViewCell.self, forCellWithReuseIdentifier: GoalDetailCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    lazy var backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: self, action: #selector(back(_:)))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.secondary as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        
        return barButtonItem
    }()
    
    func configureView(viewController: SelectBudgetCategoryViewController, isShown: Bool? = true) {
        self.viewController = viewController
        backgroundColor = .ghostWhite
        
        viewDelegate = viewController
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        
        if let isShown = isShown {
            print(isShown)
            self.isShown = isShown
        }
        
        configureNavigationControllerView()
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureNavigationControllerView() {
        navigationBarDelegate = viewController
        viewController?.navigationItem.leftBarButtonItem = backButton
    }
    
    func configureAutoLayout() {
        print((#function))
        let viewMargins = safeAreaLayoutGuide
        
        addSubview(stackView)
        stackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor)
        
        stackView.addArrangedSubview(containerView)
        if isShown {
            containerView.addSubview(addCategoryButton)
            addCategoryButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingLeft: 20, paddingBottom: 16, paddingRight: 20)
        }
        
        stackView.addArrangedSubview(collectionView)
    }
    
    func configureClickableTarget() {
        addCategoryButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
    }
    
    @objc func addCategory(_ sender: UIButton) {
        viewDelegate?.addCategory()
    }
    
    @objc func back(_ animated: Bool) {
        navigationBarDelegate?.cancel()
    }
}
