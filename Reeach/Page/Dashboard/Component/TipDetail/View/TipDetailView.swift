//
//  TipDetailView.swift
//  Reeach
//
//  Created by William Chrisandy on 17/11/22.
//

import UIKit

class TipDetailView: UIView {
    
    weak var viewController: TipDetailViewController?
    weak var navigationBarDelegate: NavigationBarDelegate?
    
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
    
    private lazy var imageViewContainerView = UIView()
    
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 5/6).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Question...?"
        label.font = UIFont.bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel = {
        let label = UILabel()
        label.text = "Answer"
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black13
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
    
    func configureView(viewController: TipDetailViewController) {
        self.viewController = viewController
        backgroundColor = .ghostWhite
        
        configureNavigationControllerView()
        configureAutoLayout()
    }
    
    private func configureAutoLayout() {
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, paddingLeft: 20)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        stackView.addArrangedSubview(imageViewContainerView)
        imageViewContainerView.addSubview(imageView)
        imageView.anchor(top: imageViewContainerView.topAnchor, bottom: imageViewContainerView.bottomAnchor, paddingTop: 20, paddingBottom: 16)
        imageView.centerX(inView: imageViewContainerView)
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/3).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func configureNavigationControllerView() {
        navigationBarDelegate = viewController
        viewController?.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func back(_ animated: Bool) {
        navigationBarDelegate?.cancel()
    }
}
