//
//  SelectGoalView.swift
//  Reeach
//
//  Created by William Chrisandy on 07/11/22.
//

import UIKit

class SelectGoalView: UIView {
    weak var viewController: SelectGoalViewController?
    weak var navigationBarDelegate: NavigationBarDelegate?
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var containerView = UIView()
    
    private lazy var collectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        return collectionViewFlowLayout
    }()
    
    lazy var collectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(GoalDetailCollectionViewCell.self, forCellWithReuseIdentifier: GoalDetailCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    lazy var explanationLabel = {
        let label = UILabel()
        label.text = "Yuk, pilih mau nabung untuk goals apa di bulan ini."
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func configureView(viewController: SelectGoalViewController) {
        self.viewController = viewController
        backgroundColor = .ghostWhite
        
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        
        configureNavigationControllerView()
        configureAutoLayout()
    }
    
    func configureNavigationControllerView() {
        navigationBarDelegate = viewController
        viewController?.navigationItem.leftBarButtonItem = backButton
    }
    
    func configureAutoLayout() {
        let viewMargins = safeAreaLayoutGuide
        
        addSubview(stackView)
        stackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor)
        
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(explanationLabel)
        explanationLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        stackView.addArrangedSubview(collectionView)
    }
    
    @objc func back(_ animated: Bool) {
        navigationBarDelegate?.cancel()
    }
}
