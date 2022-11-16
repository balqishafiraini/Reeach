//
//  BudgetingTechniqueExplanationView.swift
//  Reeach
//
//  Created by William Chrisandy on 08/11/22.
//

import UIKit

class BudgetingTechniqueExplanationView: UIView {
    
    weak var viewController: BudgetingTechniqueExplanationViewController?
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
        imageView.image = UIImage(named: "IllustrationBudget")
        return imageView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Penjelasan 50-30-20"
        label.font = UIFont.bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var questionLabel = {
        let label = UILabel()
        label.text = "Apa itu metode 50-30-20?"
        label.font = UIFont.bodyBold
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var answerLabel = {
        let label = UILabel()
        label.text = """
            50-30-20 merupakan metode pengaturan keuangan di mana kamu mengalokasikan pendapatan kamu ke dalam tiga kategori:
            • 50 persen untuk kebutuhan pokok
            • 30 persen untuk kebutuhan nonpokok
            • 20 persen untuk tabungan atau investasi

            Penggunaan metode ini akan membantu kamu membuat rencana keuangan yang lebih efektif namun tetap fleksibel.
            
            """
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureView(viewController: BudgetingTechniqueExplanationViewController) {
        self.viewController = viewController
        backgroundColor = .ghostWhite
        
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
        imageView.anchor(top: imageViewContainerView.topAnchor, bottom: imageViewContainerView.bottomAnchor, paddingTop: 44, paddingBottom: 16)
        imageView.centerX(inView: imageViewContainerView)
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/3).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(answerLabel)
    }
}
