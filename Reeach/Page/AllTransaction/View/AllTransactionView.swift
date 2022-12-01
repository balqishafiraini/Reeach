//
//  AllTransactionView.swift
//  Reeach
//
//  Created by James Christian Wira on 30/11/22.
//

import UIKit

class AllTransactionView: UIView {

    var transactions: [Date:[Transaction]] = [:]
    weak var delegate: TransactionDelegate?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        let backImage = UIImage(named: "Back")
        button.setImage(backImage, for: .normal)
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Data", for: .normal)
        
        return button
    }()
    
    lazy var buttonView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        
        view.addArrangedSubview(backButton)
        view.addArrangedSubview(UIView())
//        view.addArrangedSubview(testButton)
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Semua Transaksi"
        label.textColor = .black3
        label.textAlignment = .left
        label.font = .largeTitle
        
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.placeholder = "Cari Transaksi"
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(0.2)
        
        return searchBar
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        let filterImage = UIImage(named: "Filter")
        let tintedImage = filterImage?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(tintedImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        
        return button
    }()
    
    lazy var searchFilterStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
        stack.addArrangedSubview(searchBar)
        stack.addArrangedSubview(filterButton)
        
//        searchBar.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: -8).isActive = true
        
        return stack
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.backgroundColor = .secondary
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var transactionList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .ghostWhite
//        cv.isScrollEnabled = false
        cv.register(TransactionItemViewCell.self, forCellWithReuseIdentifier: TransactionItemViewCell.identifier)
        cv.register(HeaderGoalDetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderGoalDetailCollectionReusableView.reuseIdentifier)
        
        return cv
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .ghostWhite
        
        return stack
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    
    lazy var emptyImage: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "IllustrationTransaction")
        iv.image = image
//        iv.heightAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        
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
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emptyView.roundCorners([.topLeft, .topRight], radius: 28)
        transactionList.roundCorners([.topLeft, .topRight], radius: 28)
    }
    
    func setupView() {
        self.backgroundColor = .secondary
        
        headerStack.addArrangedSubview(buttonView)
        headerStack.addArrangedSubview(titleLabel)
        headerStack.setCustomSpacing(-2, after: titleLabel)
        headerStack.addArrangedSubview(searchFilterStack)
        headerView.addSubview(headerStack)
        
        emptyView.addSubview(emptyStack)
        
        self.addSubview(headerView)
        self.addSubview(transactionList)
        self.addSubview(emptyView)
        
        headerView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, right: self.rightAnchor)
        headerStack.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 20)
        
        transactionList.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor)
        
        emptyView.anchor(top: headerStack.bottomAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor)
        emptyStack.center(inView: emptyView)
        emptyView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emptyImage.widthAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 0.75).isActive = true
        emptyImage.heightAnchor.constraint(equalTo: emptyImage.widthAnchor).isActive = true
        
        if transactions.isEmpty {
            transactionList.isHidden = true
            emptyView.isHidden = false
        } else {
            transactionList.isHidden = false
            emptyView.isHidden = true
        }
        
        setButtonTarget()
    }
    
    func setupViewInitial() {
        self.backgroundColor = .secondary
        
        headerStack.addArrangedSubview(buttonView)
        headerStack.addArrangedSubview(titleLabel)
        headerStack.setCustomSpacing(-2, after: titleLabel)
        headerStack.addArrangedSubview(searchFilterStack)
        headerView.addSubview(headerStack)
        
        if transactions.count <= 0 {
            print("here first")
            contentStack.addArrangedSubview(emptyStack)
        } else {
            print("here second")
            contentStack.addArrangedSubview(transactionList)
            transactionList.anchor(top: contentStack.topAnchor, left: contentStack.leftAnchor, bottom: contentStack.bottomAnchor, right: contentStack.rightAnchor)
        }
        
        contentView.addSubview(contentStack)
        
        mainStack.addArrangedSubview(headerView)
        mainStack.addArrangedSubview(contentView)
        
        scrollView.addSubview(mainStack)
        
        self.addSubview(background)
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor)
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        mainStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        headerStack.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 20)
        
        contentStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        
        background.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        background.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        setButtonTarget()
    }
    
    func setButtonTarget() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        testButton.addTarget(self, action: #selector(populateDummyData), for: .touchUpInside)
        
        searchBar.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
        searchBar.searchTextField.sendActions(for: .valueChanged)
    }
    
    @objc func back() {
        print(#function)
    }
    
    @objc func openFilter() {
        print(#function)
        delegate?.openSheet()
    }
    
    @objc func search() {
        delegate?.search(searchText: searchBar.searchTextField.text ?? "")
    }
    
    @objc func populateDummyData() {
        print(#function)
        
        let secondsInDay = 86400.0
        var days: [Date] = []
        for i in 0...60 {
            days.append(Date.init(timeInterval: Double(i) * secondsInDay, since: Date()))
        }
        
        let dbHelper = DatabaseHelper.shared
        
        var transactions = dbHelper.getTransactions()
        
        for transaction in transactions {
            dbHelper.delete(transaction)
        }

        let foodCategory = dbHelper.getCategory(name: "Makanan")
        let foodBudget = dbHelper.getBudget(on: Date(), of: foodCategory!)

        let _ = dbHelper.createTransaction(name: "Gyukuka", date: days[0], budget: foodBudget!, amount: 300000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Soloria", date: days[0], budget: foodBudget!, amount: 75000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "WcDonald", date: days[5], budget: foodBudget!, amount: 30000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Lowsan", date: days[6], budget: foodBudget!, amount: 15000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Chinamaret", date: days[10], budget: foodBudget!, amount: 15000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Sun Chicken", date: days[10], budget: foodBudget!, amount: 35000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Piringku", date: days[10], budget: foodBudget!, amount: 30000, notes: "Mahal banget")

        let transportCategory = dbHelper.getCategory(name: "Transportasi")
        let transportBudget = dbHelper.getBudget(on: Date(), of: transportCategory!)

        let _ = dbHelper.createTransaction(name: "Gojek", date: days[0], budget: transportBudget!, amount: 10000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Gojek", date: days[0], budget: transportBudget!, amount: 10000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Gocar", date: days[5], budget: transportBudget!, amount: 30000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Bensin mobil 30L", date: days[6], budget: transportBudget!, amount: 300000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Gocar", date: days[44], budget: transportBudget!, amount: 15000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Gocar", date: days[35], budget: transportBudget!, amount: 35000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Gojek", date: days[10], budget: transportBudget!, amount: 30000, notes: "Mahal banget")
        
        let incomeCategory = dbHelper.getCategory(name: "Income")
        let incomeBudget = dbHelper.getBudget(on: Date(), of: incomeCategory!)

        let _ = dbHelper.createTransaction(name: "Gaji", date: days[28], budget: incomeBudget!, amount: 10000000, notes: "Mahal banget")
        
        let subsCategory = dbHelper.getCategory(name: "Langganan")
        let subsBudget = dbHelper.getBudget(on: Date(), of: subsCategory!)

        let _ = dbHelper.createTransaction(name: "Netflix", date: days[28], budget: subsBudget!, amount: 100000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Disney+", date: days[23], budget: subsBudget!, amount: 90000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Hulu", date: days[17], budget: subsBudget!, amount: 200000, notes: "Mahal banget")
        let _ = dbHelper.createTransaction(name: "Vidio", date: days[15], budget: subsBudget!, amount: 200000, notes: "Mahal banget")
    }
}
