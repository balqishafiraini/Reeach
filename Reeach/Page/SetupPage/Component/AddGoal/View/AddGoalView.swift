//
//  AddGoal.swift
//  Reeach
//
//  Created by James Christian Wira on 21/10/22.
//

import UIKit

class AddGoal: UIView {
    
    weak var delegate: SetupDelegate?
    weak var controller: AddGoalViewController?
    
    var goals: [Goal]
    
    let size = 36.0
    
    lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Goal"
        label.font = .largeTitle
        
        return label
    }()
    
    lazy var addButton: UIView = {
        let view = UIView()
        
        let button = UIButton()
        
        let icon = UIImage(named: "Add")
        
        button.setImage(icon, for: .normal)
        button.tintColor = .black
        
        view.addSubview(button)
        view.setDimensions(width: size, height: size)
        view.backgroundColor = .tangerineYellow
        view.layer.cornerRadius = size * 0.5
        
        button.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openGoalSheet))
        
        button.addTarget(self, action: #selector(openGoalSheet), for: .touchUpInside)
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    lazy var topStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var viewDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Goals yang baik punya karakteristik S.M.A.R.T atau specific, measurable, achievable, relevant, dan time-bounded. Yuk, tuliskan goals kamu!"
        label.font = .bodyMedium
        label.numberOfLines = 5
        label.textColor = .black8
        
        return label
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    
    lazy var emptyImage: UIImageView = {
        let image = UIImageView()
//        image.setDimensions(width: 300, height: 300)
        image.image = UIImage(named: "IllustrationGoal")
        
        return image
    }()
    
    lazy var emptyDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Klik '+' untuk menambah target"
        label.font = .bodyMedium
        label.textColor = .black7
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var emptyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        
        return stack
    }()
    
    lazy var goalList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(GoalItemCollectionViewCell.self, forCellWithReuseIdentifier: GoalItemCollectionViewCell.identifier)
        
        return cv
    }()
    
    init (frame: CGRect, goals: [Goal]) {
        self.goals = goals
        
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        self.goals = []
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        goalList.delegate = controller
        goalList.dataSource = controller
        
        self.backgroundColor = .ghostWhite
        self.addSubview(headerStack)
        self.addSubview(emptyView)
        self.addSubview(goalList)
    
        if goals.isEmpty {
            goalList.removeFromSuperview()
            removeConstraints(goalList.constraints)

            emptyStack.addArrangedSubview(emptyImage)
            emptyStack.addArrangedSubview(emptyDescription)
//            emptyView.backgroundColor = .red

            emptyView.addSubview(emptyStack)
            
//            emptyDescription.anchor(top: emptyImage.bottomAnchor, paddingTop: 12)
//            emptyDescription.centerX(inView: emptyView)

            emptyView.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
            
            emptyStack.center(inView: emptyView)
            
            emptyImage.widthAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 6.5/10).isActive = true
            emptyImage.heightAnchor.constraint(equalTo: emptyImage.widthAnchor).isActive = true
        } else {
            emptyView.removeFromSuperview()
            removeConstraints(emptyView.constraints)

            goalList.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            goalList.backgroundColor = .ghostWhite
        }
        
        headerStack.addArrangedSubview(topStack)
        headerStack.addArrangedSubview(viewDescription)

        topStack.addArrangedSubview(topTitle)
        topStack.addArrangedSubview(addButton)

        headerStack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)

    }
    
    @objc func openGoalSheet() {
        delegate?.openGoalSheet?(forGoalIndex: -1)
    }
    
    
}
