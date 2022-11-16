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
    
    let size = 44.0
    
    lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Goal"
        label.font = .largeTitle
        
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        
        let icon = UIImage(systemName: "plus")
        
        button.setImage(icon, for: .normal)
        button.backgroundColor = .tangerineYellow
        button.tintColor = .black
        button.setDimensions(width: size, height: size)
        button.layer.cornerRadius = size / 2
        
        return button
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
        image.image = UIImage(named: "EmptyImage")
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return image
    }()
    
    lazy var emptyDescription: UILabel = {
        let label = UILabel()
        
        label.text = "Klik '+' untuk menambah target"
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var goalList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
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
        
        self.addSubview(headerStack)
        self.addSubview(emptyView)
        self.addSubview(goalList)
        
        addButton.addTarget(self, action: #selector(openGoalSheet), for: .touchUpInside)
    
        if goals.isEmpty {
            goalList.removeFromSuperview()
            removeConstraints(goalList.constraints)

            emptyView.addSubview(emptyImage)
            emptyView.addSubview(emptyDescription)

            emptyImage.center(inView: emptyView)
            emptyDescription.anchor(top: emptyImage.bottomAnchor, paddingTop: 12)
            emptyDescription.centerX(inView: emptyView)

            emptyView.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        } else {
            emptyView.removeFromSuperview()
            removeConstraints(emptyView.constraints)

            goalList.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        }
        
        headerStack.addArrangedSubview(topStack)
        headerStack.addArrangedSubview(viewDescription)

        topStack.addArrangedSubview(topTitle)
        topStack.addArrangedSubview(addButton)

        headerStack.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)

    }
    
    @objc func openGoalSheet() {
        delegate?.openGoalSheet?()
    }
    
    
}
