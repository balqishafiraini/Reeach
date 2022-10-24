//
//  AddGoal.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

class AddGoal: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
//        self.setDimensions(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.maxY)
        
        let topTitle: UILabel = {
            let label = UILabel()
            label.text = "Goal"
            label.font = label.font.withSize(32)
            
            return label
        }()
        
        let addButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.tintColor = .white
            button.backgroundColor = .black
            
            button.titleLabel?.font.withSize(32)
            
            return button
        }()
        
        let topStack: UIStackView = {
            let stack = UIStackView()
            
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .equalSpacing
            
            stack.addArrangedSubview(topTitle)
            stack.addArrangedSubview(addButton)
            
            return stack
        }()
        
        let viewDescription: UILabel = {
            let label = UILabel()
            
            label.text = "Yuk tambah tujuan finansial mu sekarang, tujuan finansialmu harus SMART, yaitu  Lorem ipsum dolor sit amet sit ."
            label.font = label.font.withSize(12)
            label.numberOfLines = 5
            
            return label
        }()
        
        let headerStack: UIStackView = {
            let stack = UIStackView()
            stack.backgroundColor = .red
            
            stack.axis = .vertical
            stack.spacing = 32
            stack.distribution = .fillProportionally
            
            stack.addArrangedSubview(topStack)
            stack.addArrangedSubview(viewDescription)
            
            return stack
        }()
        
        
        let emptyImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "EmptyImage")
            image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            
            return image
        }()
        
        let emptyDescription: UILabel = {
            let label = UILabel()
            
            label.text = "Klik '+' untuk menambah target"
            label.font = label.font.withSize(14)
            
            return label
        }()
        
        let emptyView: UIView = {
            let view = UIView()
            
            view.addSubview(emptyImage)
            view.addSubview(emptyDescription)
            view.backgroundColor = .blue
            
            emptyImage.center(inView: view)
            emptyDescription.anchor(top: emptyImage.bottomAnchor, paddingTop: 12)
            emptyDescription.centerX(inView: view)
            
            return view
        }()
        
        self.addSubview(headerStack)
        self.addSubview(emptyView)
        
        headerStack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        topStack.anchor(top: headerStack.topAnchor, left: headerStack.leftAnchor, right: headerStack.rightAnchor)
        
        emptyView.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
}
