//
//  TipCardView.swift
//  Reeach
//
//  Created by William Chrisandy on 09/11/22.
//

import UIKit

class TipCardView: UIView {
    var tip: Tip?
    
    private lazy var horizontalStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelContainer = UIView()
    
    lazy var label = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyMedium
        label.textColor = .black13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 125, height: 125)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .cardColor
        layer.cornerRadius = 20
        
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        addSubview(horizontalStackView)
        horizontalStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        horizontalStackView.addArrangedSubview(labelContainer)
        labelContainer.addSubview(label)
        label.anchor(top: labelContainer.topAnchor, left: labelContainer.leftAnchor, bottom: labelContainer.bottomAnchor, right: labelContainer.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
        horizontalStackView.addArrangedSubview(imageView)
    }
    
    func setTip(_ tip: Tip) {
        self.tip = tip
        label.text = tip.description
        imageView.image = tip.coverImage
    }
}
