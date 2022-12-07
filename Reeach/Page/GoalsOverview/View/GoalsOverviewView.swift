//
//  GoalsOverviewView.swift
//  Reeach
//
//  Created by Balqis on 15/11/22.
//

import UIKit

class GoalsOverviewView: UIView {
    weak var viewDelegate: GoalsOverviewViewDelegate?
    weak var viewController: GoalsOverviewViewController?
    
    //scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var headerView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureAutoLayout()
        return view
    }()
    
    lazy var messageLabelContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondary
        return view
    }()
    
    lazy var messageLabelBlankView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    lazy var messageLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Slaaay. Kalau kamu konsisten fix bisa tercapai nih goalsnya, bestie. 🥳"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkSlateGray
        label.font = .headline
        label.backgroundColor = .secondary2
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.paddingRight = 24
        label.paddingLeft = 24
        label.paddingTop = 20
        label.paddingBottom = 20
        return label
    }()
    
    lazy var progressViewContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = .secondary
        progressView.trackTintColor = .black5
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        progressView.anchor(height: 20)
        return progressView
    }()
    
    lazy var percentageLabelContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30% tercapai"
        label.font = .bodyMedium
        label.textAlignment = .center
        label.textColor = .black13
        return label
    }()
    
    lazy var deadlineHeaderContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    lazy var deadlineHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Deadline"
        label.font = .bodyBold
        label.textColor = .black13
        return label
    }()
    
    lazy var deadlineView = {
        let view = DeadlineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureAutoLayout()
        return view
    }()
    
    lazy var statusHeaderContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        return view
    }()
    
    lazy var statusHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status Saat Ini"
        label.font = .bodyBold
        label.textColor = .black13
        return label
    }()
    
    lazy var statusView = {
        let view = StatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureAutoLayout()
        return view
    }()

    private lazy var blankView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        return view
    }()
    
    func configureView(viewController: GoalsOverviewViewController) {
        self.viewController = viewController
        backgroundColor = .royalHunterBlue
        
        viewDelegate = viewController
        
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureAutoLayout() {
        addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
        
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor).isActive = true
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(messageLabelContainerView)
        stackView.addArrangedSubview(progressViewContainerView)
        stackView.addArrangedSubview(percentageLabelContainerView)
        stackView.addArrangedSubview(deadlineHeaderContainerView)
        stackView.addArrangedSubview(deadlineView)
        stackView.addArrangedSubview(statusHeaderContainerView)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(blankView)
        
        messageLabelContainerView.addSubview(messageLabelBlankView)
        messageLabelContainerView.addSubview(messageLabel)
        
        messageLabelBlankView.anchor(top: messageLabelContainerView.centerYAnchor, left: messageLabelContainerView.leftAnchor, bottom: messageLabelContainerView.bottomAnchor, right: messageLabelContainerView.rightAnchor)
        
        messageLabel.anchor(top: messageLabelContainerView.topAnchor, left: messageLabelContainerView.leftAnchor, bottom: messageLabelContainerView.bottomAnchor, right: messageLabelContainerView.rightAnchor, paddingTop: 4, paddingLeft: 20, paddingBottom: 4, paddingRight: 20)
        
        
        progressViewContainerView.addSubview(progressView)
        progressView.anchor(top: progressViewContainerView.topAnchor, left: progressViewContainerView.leftAnchor, bottom: progressViewContainerView.bottomAnchor, right: progressViewContainerView.rightAnchor, paddingTop: 24, paddingLeft: 20, paddingRight: 20)
        
        
        percentageLabelContainerView.addSubview(percentageLabel)
        percentageLabel.anchor(top: percentageLabelContainerView.topAnchor, left: percentageLabelContainerView.leftAnchor, bottom: percentageLabelContainerView.bottomAnchor, right: percentageLabelContainerView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
        
        
        deadlineHeaderContainerView.addSubview(deadlineHeaderLabel)
        deadlineHeaderLabel.anchor(top: deadlineHeaderContainerView.topAnchor, left: deadlineHeaderContainerView.leftAnchor, bottom: deadlineHeaderContainerView.bottomAnchor, right: deadlineHeaderContainerView.rightAnchor, paddingTop: 24, paddingLeft: 20, paddingBottom: 12, paddingRight: 20)
        
        
        statusHeaderContainerView.addSubview(statusHeaderLabel)
        statusHeaderLabel.anchor(top: statusHeaderContainerView.topAnchor, left: statusHeaderContainerView.leftAnchor, bottom: statusHeaderContainerView.bottomAnchor, right: statusHeaderContainerView.rightAnchor, paddingTop: 24, paddingLeft: 20, paddingBottom: 12, paddingRight: 20)
        
    }
    
    func configureClickableTarget() {
        headerView.editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        headerView.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back() {
        viewDelegate?.back()
    }
    
    @objc func edit() {
        viewDelegate?.goToEditMode()
    }
}

class HeaderView: UIView {
    private lazy var verticalStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .secondary
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backButtonHorizontalStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backButtonBlankView = {
        let view = UIView()
        view.anchor(width: 20)
        return view
    }()
    
    lazy var backButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.anchor(width: 28)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.text = "🤡"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var goalNameContainerView = UIView()
    
    private lazy var goalNameHorizontalStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var goalNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Asuransi"
        label.font = .title
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var termLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Medium-term"
        label.font = .caption2Medium
        label.textColor = .royalHunterBlue
        label.textAlignment = .center
        label.backgroundColor = .ghostWhite
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.paddingRight = 8
        label.paddingLeft = 8
        label.paddingTop = 4
        label.paddingBottom = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var initialSavingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sudah Terkumpul"
        label.font = .caption1Medium
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var initialSavingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp66.000.000"
        label.font = .largeTitle
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var targetAmountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dari"
        label.font = .caption1Medium
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var targetAmountValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp66.000.000"
        label.font = .largeTitle
        label.textColor = .ghostWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    lazy var editButton: UIButton = {
        let button = UIButton()
        button.tintColor = .tangerineYellow
        button.setImage(UIImage(named: "Edit"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func configureAutoLayout() {
        backgroundColor = .secondary
        
        addSubview(verticalStackView)
        verticalStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingBottom: 24)
        
        verticalStackView.addArrangedSubview(backButtonHorizontalStackView)
        verticalStackView.setCustomSpacing(10, after: backButtonHorizontalStackView)
        verticalStackView.addArrangedSubview(iconLabel)
        verticalStackView.setCustomSpacing(10, after: iconLabel)
        verticalStackView.addArrangedSubview(goalNameContainerView)
        verticalStackView.setCustomSpacing(8, after: goalNameContainerView)
        verticalStackView.addArrangedSubview(termLabel)
        verticalStackView.setCustomSpacing(20, after: termLabel)
        verticalStackView.addArrangedSubview(initialSavingTitleLabel)
        verticalStackView.addArrangedSubview(initialSavingValueLabel)
        verticalStackView.setCustomSpacing(8, after: initialSavingValueLabel)
        verticalStackView.addArrangedSubview(targetAmountTitleLabel)
        verticalStackView.addArrangedSubview(targetAmountValueLabel)
        
        backButtonHorizontalStackView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor).isActive = true
        backButtonHorizontalStackView.addArrangedSubview(backButtonBlankView)
        backButtonHorizontalStackView.addArrangedSubview(backButton)
        backButtonHorizontalStackView.addArrangedSubview(UIView())
        
        goalNameContainerView.addSubview(goalNameHorizontalStackView)
        goalNameContainerView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor).isActive = true
        goalNameHorizontalStackView.anchor(top: goalNameContainerView.topAnchor, bottom: goalNameContainerView.bottomAnchor)
        goalNameHorizontalStackView.centerX(inView: goalNameContainerView)
        
        goalNameHorizontalStackView.addArrangedSubview(goalNameLabel)
        goalNameHorizontalStackView.addArrangedSubview(editButton)
    }
    
}

class DeadlineView: UIView {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.anchor(width: 66, height: 66)
        imageView.image = UIImage(named: "IllustrationDeadline")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.text = "02/2026"
        label.font = .bodyBold
        label.textColor = .darkSlateGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureAutoLayout() {
        backgroundColor = .ghostWhite
        
        addSubview(backgroundView)
        backgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        backgroundView.addSubview(horizontalStackView)
        horizontalStackView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        horizontalStackView.addArrangedSubview(imageView)
        horizontalStackView.addArrangedSubview(dueDateLabel)
        horizontalStackView.addArrangedSubview(UIView())
        horizontalStackView.setCustomSpacing(0, after: dueDateLabel)
    }
}

class StatusView: UIView {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.anchor(width: 66, height: 66)
        imageView.image = UIImage(named: "IllustrationActive")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Goal Aktif"
        label.font = .bodyBold
        label.textColor = .darkSlateGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureAutoLayout() {
        backgroundColor = .ghostWhite
        
        addSubview(backgroundView)
        backgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        backgroundView.addSubview(horizontalStackView)
        horizontalStackView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        horizontalStackView.addArrangedSubview(imageView)
        horizontalStackView.addArrangedSubview(statusLabel)
        horizontalStackView.addArrangedSubview(UIView())
        horizontalStackView.setCustomSpacing(0, after: statusLabel)
    }
}
