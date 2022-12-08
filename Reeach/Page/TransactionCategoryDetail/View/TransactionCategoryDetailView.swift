//
//  TransactionCategoryDetailView.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TransactionCategoryDetailView: UIView {
    
    var category: Category?
    var budget: Budget?
    var formattedTransactions: [Date: [Transaction]] = [:]
    var sortedKeys: [Date] = []
    weak var delegate: TransactionDelegate?
    
    // MARK: Start Header
    lazy var backButton: UIButton = {
        let button = UIButton()
        let backImage = UIImage(named: "Back")
        button.setImage(backImage, for: .normal)
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    lazy var buttonView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        
        view.addArrangedSubview(backButton)
        view.addArrangedSubview(UIView())
        
        return view
    }()
    
    lazy var categoryIconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 44)
        
        return label
    }()
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var categoryTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2Medium
        label.textColor = .secondary6
        
        return label
    }()
    
    lazy var categoryTypeView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        let view = UIView()
        view.backgroundColor = .ghostWhite
        view.layer.cornerRadius = 12
        view.sizeToFit()
        
        view.addSubview(categoryTypeLabel)
        categoryTypeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        stack.addArrangedSubview(view)
        stack.addArrangedSubview(UIView())
        
        return stack
    }()
    
    lazy var categoryTitleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        
        stack.addArrangedSubview(categoryTitleLabel)
        stack.addArrangedSubview(categoryTypeView)
        
        return stack
    }()
    
    lazy var categoryHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        
        stack.addArrangedSubview(categoryIconLabel)
        stack.addArrangedSubview(categoryTitleStack)
        stack.addArrangedSubview(UIView())
        
        return stack
    }()
    
    lazy var remainingLabel: UILabel = {
        let label = UILabel()
        label.text = "Sisa budget bulan ini"
        label.font = .caption1Medium
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var remainingAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitle
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var remainingBudgetProgress: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .black5
        progressView.layer.cornerRadius = 7
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 7
        progressView.subviews[1].clipsToBounds = true
        progressView.anchor(height: 12)
        progressView.progressTintColor = .accentGreen
        
        return progressView
    }()
    
    lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.text = "Pengeluaran"
        label.font = .caption1Medium
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1Bold
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var expenseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(expenseLabel)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(expenseAmountLabel)
        
        return stack
    }()
    
    lazy var budgetLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Budget"
        label.font = .caption1Medium
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var budgetAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1Bold
        label.textColor = .ghostWhite
        
        return label
    }()
    
    lazy var budgetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(budgetLabel)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(budgetAmountLabel)
        
        return stack
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondary
        
        return view
    }()
    // MARK: End Header
    
    // MARK: Start Content
    lazy var tipIconLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var tipStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(tipIconLabel)
        stack.addArrangedSubview(tipLabel)
        
        return stack
    }()
    
    lazy var tipView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardColor
        
        view.addSubview(tipStack)
        tipStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        return view
    }()
    
    lazy var historyLabel: UIView = {
        let view = UIView()
        
        let label = UILabel()
        label.text = "Riwayat Pengeluaran"
        label.font = .title
        label.textColor = .black13
        
        view.addSubview(label)
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.placeholder = "Cari Transaksi"
        
        return searchBar
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        let filterImage = UIImage(named: "Filter")
        let tintedImage = filterImage?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(tintedImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        
        return button
    }()
    
    lazy var searchFilterStack: UIView = {
        let view = UIView()
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(searchBar)
        stack.addArrangedSubview(filterButton)
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingRight: 20)
        
        return view
    }()
    
    lazy var addTransactionButton = Button(style: .rounded, title: "Catat Pengeluaran ...", textColor: .black13, backColor: .primary)
    
    lazy var addTransactionButtonView: UIView = {
        let view = UIView()
        
        view.addSubview(addTransactionButton)
        addTransactionButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        return view
    }()
    
    lazy var transactionStackList: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    // MARK: End Content
    
    // MARK: Start Empty State
    lazy var emptyImage: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "IllustrationTransaction")
        iv.image = image
        
        return iv
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Kamu belum memiliki transaksi, nih. Jangan lupa catat transaksi kamu, ya!"
        label.textColor = .black7
        label.textAlignment = .center
        label.numberOfLines = 5
        
        return label
    }()
    
    lazy var emptyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.addArrangedSubview(emptyImage)
        stack.addArrangedSubview(emptyLabel)
        
        return stack
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    // MARK: End Empty State
    
    // MARK: Start Transaction Items
    let transactionHeader = HeaderGoalDetailCollectionReusableView()
    let trasactionItem = TransactionItemViewCell()
    // MARK: End Transaction Items
    
    // MARK: Start Main View
    lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .secondary
        
        return sv
    }()
    // MARK: End Main View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(category: Category?, budget: Budget?, transactions: [Date: [Transaction]]? = [:], sortedKeys: [Date]? = []) {
        formattedTransactions.removeAll()
        self.sortedKeys.removeAll()
        
        self.budget = budget
        
        categoryIconLabel.text = category!.icon
        categoryTitleLabel.text = category!.name
        categoryTypeLabel.text = getCategoryLabel(type: category!.type!)
        
        addTransactionButton.setTitle("Catat Pengeluaran \(category!.name!)", for: .normal)
        
        self.formattedTransactions = transactions ?? [:]
        self.sortedKeys = sortedKeys ?? []
    }
    
    func getCategoryLabel(type: String) -> String {
        switch type {
            case "Goal":
                return "Goal"
            case "Need":
                return "Kebutuhan Pokok"
            case "Want":
                return "Kebutuhan Non-Pokok"
            case "Income":
                return "Pemasukan"
            default:
                return "Huh? Something's wrong here"
        }
    }
    
    func setupHeaderLayout() {
        headerStack.addArrangedSubview(buttonView)
        headerStack.addArrangedSubview(categoryHeaderStack)
        headerStack.setCustomSpacing(16, after: categoryHeaderStack)
        headerStack.addArrangedSubview(remainingLabel)
        headerStack.addArrangedSubview(remainingAmountLabel)
        headerStack.setCustomSpacing(12, after: remainingAmountLabel)
        headerStack.addArrangedSubview(remainingBudgetProgress)
        headerStack.addArrangedSubview(expenseStack)
        headerStack.setCustomSpacing(4, after: expenseStack)
        headerStack.addArrangedSubview(budgetStack)
        
        headerView.addSubview(headerStack)
        headerStack.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, paddingTop: 20,paddingLeft: 20,paddingBottom: 20, paddingRight: 20)
    }
    
    func setupContentLayout() {
        contentStack.addArrangedSubview(historyLabel)
        contentStack.setCustomSpacing(4, after: historyLabel)
        contentStack.addArrangedSubview(searchFilterStack)
        contentStack.setCustomSpacing(8, after: searchFilterStack)
        contentStack.addArrangedSubview(addTransactionButtonView)
        
        if formattedTransactions.isEmpty {
            transactionStackList.isHidden = true
            emptyView.isHidden = false
            
            emptyView.addSubview(emptyStack)
            contentStack.addArrangedSubview(emptyView)
            
            emptyStack.anchor(top: emptyView.topAnchor, left: emptyView.leftAnchor, bottom: emptyView.bottomAnchor, right: emptyView.rightAnchor, paddingLeft: 20, paddingRight: 20)
            emptyImage.heightAnchor.constraint(equalTo: emptyImage.widthAnchor).isActive = true
            
            budgetAmountLabel.text = CurrencyHelper.getCurrency(from: budget!.monthlyAllocation)
            expenseAmountLabel.text = CurrencyHelper.getCurrency(from: 0.0)
            remainingAmountLabel.text = CurrencyHelper.getCurrency(from: budget!.monthlyAllocation)
            remainingBudgetProgress.setProgress(1.0, animated: false)
        } else {
            transactionStackList.isHidden = false
            emptyView.isHidden = true
            
            transactionStackList = {
                let stack = UIStackView()
                stack.axis = .vertical
                stack.distribution = .fill
                
                return stack
            }()
            
            setupTransactionList()

            contentStack.addArrangedSubview(transactionStackList)
        }
        
        contentView.addSubview(contentStack)
        contentStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingBottom: 20)
    }
    
    func setupView() {
        self.backgroundColor = .secondary
        
        setupHeaderLayout()
        setupContentLayout()
        
        containerStack.addArrangedSubview(headerView)
        containerStack.addArrangedSubview(contentView)
        
        containerView.addSubview(containerStack)
        
        scrollView.addSubview(containerView)
       
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor)
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerStack.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor)
        
        setupTargets()
    }
    
    func setupTransactionList() {
        var totalExpense = 0.0
        let totalBudget = budget!.monthlyAllocation
        
        for key in sortedKeys {
            let newHeader = HeaderGoalDetailCollectionReusableView()
            newHeader.titleLabel.text = DateFormatHelper.getDDddMMyyy(from: key)
            
            transactionStackList.addArrangedSubview(newHeader)
            
            for transaction in formattedTransactions[key]! {
                let newItem = TransactionItemViewCell()
                newItem.setupData(transaction: transaction)
                newItem.setupView()
                
                totalExpense += transaction.amount
                
                transactionStackList.addArrangedSubview(newItem)
                transactionStackList.setCustomSpacing(8, after: newItem)
            }
        }
        
        budgetAmountLabel.text = CurrencyHelper.getCurrency(from: totalBudget)
        expenseAmountLabel.text = CurrencyHelper.getCurrency(from: totalExpense)
        
        remainingAmountLabel.text = CurrencyHelper.getCurrency(from: (totalBudget - totalExpense))
        remainingBudgetProgress.setProgress(Float((totalBudget - totalExpense) / totalBudget), animated: false)
    }
    
    func setupTargets() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        
        searchBar.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
        searchBar.searchTextField.sendActions(for: .valueChanged)
        
        addTransactionButton.addTarget(self, action: #selector(openTransactionModal), for: .touchUpInside)
    }
    
    func removeStack() {
        transactionStackList.removeFromSuperview()
    }
    
    @objc func back() {
        delegate?.dismiss()
    }
    
    @objc func openFilter() {
        delegate?.openSheet()
    }
    
    @objc func search() {
        delegate?.search(searchText: searchBar.searchTextField.text ?? "")
    }
    
    @objc func openTransactionModal() {
        delegate?.openTransactionModal()
    }
}
