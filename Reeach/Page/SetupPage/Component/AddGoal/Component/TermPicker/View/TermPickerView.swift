//
//  TermPickerView.swift
//  Reeach
//
//  Created by William Chrisandy on 02/11/22.
//

import UIKit

class TermPickerView: UIView {
    
    weak var viewController: TermPickerViewController?
    weak var navigationBarDelegate: NavigationBarDelegate?
    
    private lazy var collectionViewFlowLayout = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        return collectionViewFlowLayout
    }()
    
    lazy var collectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
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
    
    func configureView(viewController: TermPickerViewController) {
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
        
        addSubview(collectionView)
        collectionView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, right: viewMargins.rightAnchor, paddingTop: 12)
    }
    
    @objc func back(_ animated: Bool) {
        navigationBarDelegate?.cancel()
    }
}
