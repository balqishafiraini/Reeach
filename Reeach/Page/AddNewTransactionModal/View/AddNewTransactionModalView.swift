//
//  AddNewTransactionModalView.swift
//  Reeach
//
//  Created by James Christian Wira on 06/12/22.
//

import UIKit

class AddNewTransactionModalView: UIView {

    weak var delegate: AddTransactionDelegate?
    weak var filterDelegate: FilterDelegate?
    
    var transaction: Transaction?
    var budget: Budget?
    
    var income: Double = 0.0
    var date: Date = Date()
    
    lazy var emptyStateContainerView = UIView()
    
    private lazy var emptyStateStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var imageViewContainerView = UIView()
    
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 5/6).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "EmptyMonthlyPlan")
        return imageView
    }()
    
    private lazy var emptyDescriptionContainerView = UIView()
    
    lazy var emptyDescriptionLabel = {
        let label = UILabel()
        label.text = "Buat monthly budget plan untuk bisa menambahkan transaksi di bulan ini."
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .black7
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emptyGoalButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Ayo buat budget!")
    
    private lazy var iconContainerView = UIView()
    
    private lazy var backgroundView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.anchor(width: 120, height: 120)
        view.layer.cornerRadius = 60
        view.backgroundColor = .secondary2
        return view
    }()
    
    lazy var iconTextField: UIEmojiTextField = {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.font = UIFont.systemFont(ofSize: 56)
        emojiTextField.attributedPlaceholder = NSAttributedString(
            string: "No Icon",
            attributes: [
                NSAttributedString.Key.font: UIFont.bodyMedium as Any,
                NSAttributedString.Key.foregroundColor: UIColor.secondary7 as Any
            ]
        )
        emojiTextField.tintColor = .clear
        emojiTextField.textAlignment = .center
        emojiTextField.isUserInteractionEnabled = false
        emojiTextField.translatesAutoresizingMaskIntoConstraints = false
        return emojiTextField
    }()
    
    lazy var transactionName: TextField = {
        let textField = TextField(frame: .zero, title: "Nama Transaksi", style: .template)
        textField.textField.placeholder = "Kamu habis beli apa?"
        
        return textField
    }()

    lazy var transactionAmount: TextField = {
        let textField = TextField(frame: .zero, title: "Nominal Transaksi", style: .template, prefix: "Rp ")
        textField.textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var transactionDate = {
        let datePicker = DatePicker(frame: .zero, title: "Tanggal Transaksi")
        datePicker.datePicker.minimumDate = DateFormatHelper.getStartDateOfMonth(of: Date())
        datePicker.datePicker.maximumDate = DateFormatHelper.getStartDateOfNextMonth(of: Date()).addingTimeInterval(-1)
        return datePicker
    }()
    
    lazy var transactionType: TextField = {
        let textField = TextField(frame: .zero, title: "Jenis Transaksi", style: .template, icon: UIImage(named: "ChevronRight"))
        textField.textField.placeholder = "Pilih jenis transaksi"
        textField.textField.isEnabled = false
        
        return textField
    }()
    
    lazy var transactionBudgetCategory: TextField = {
        let textField = TextField(frame: .zero, title: "Kategori Budget", style: .template, icon: UIImage(named: "ChevronRight"))
        textField.textField.placeholder = "Pilih kategori budget"
        textField.textField.isEnabled = false
        
        return textField
    }()
    
    lazy var blankView = {
        let view = UIView()
        view.anchor(height: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ghostWhite
        return view
    }()

    lazy var formStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        transactionBudgetCategory.textField.text = budget?.category?.name ?? "Lainnya"
        
        if let transaction = transaction {
            iconTextField.text = transaction.budget?.category?.icon
            transactionName.textField.text = transaction.name
            transactionAmount.textField.text = CurrencyHelper.getFormattedNumber(from: transaction.amount)
            transactionDate.textField.textField.text = DateFormatHelper.getDDMMyyyy(from: transaction.date!)
            transactionBudgetCategory.textField.text = transaction.budget?.category?.name ?? "Lainnya"
            income = transaction.amount
            date = transaction.date!
        }
    }
    
    func setupView() {
        setupData()
        self.backgroundColor = .ghostWhite
        
        iconContainerView.addSubview(backgroundView)
        backgroundView.centerX(inView: iconContainerView)
        backgroundView.anchor(top: iconContainerView.topAnchor, bottom: iconContainerView.bottomAnchor)
        
        iconContainerView.addSubview(iconTextField)
        iconTextField.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor)
        
        formStack.addArrangedSubview(iconContainerView)
        formStack.addArrangedSubview(transactionName)
        formStack.addArrangedSubview(transactionAmount)
        formStack.addArrangedSubview(transactionDate)
        formStack.addArrangedSubview(transactionType)
        formStack.addArrangedSubview(transactionBudgetCategory)
        formStack.addArrangedSubview(blankView)
        
        scrollView.addSubview(formStack)
        
        self.addSubview(scrollView)
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor)
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        formStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        formStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        addSubview(emptyStateContainerView)
        emptyStateContainerView.anchor(left: safeAreaLayoutGuide.leftAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingLeft: 20, paddingRight: 20)
        emptyStateContainerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
        
        emptyStateContainerView.addSubview(emptyStateStackView)
        emptyStateStackView.anchor(top: emptyStateContainerView.topAnchor, left: emptyStateContainerView.leftAnchor, bottom: emptyStateContainerView.bottomAnchor, right: emptyStateContainerView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        emptyStateStackView.addArrangedSubview(imageViewContainerView)
        emptyStateStackView.addArrangedSubview(emptyDescriptionContainerView)
        emptyStateStackView.addArrangedSubview(emptyGoalButton)
        
        imageViewContainerView.addSubview(imageView)
        imageView.center(inView: imageViewContainerView)
        imageViewContainerView.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
        
        emptyDescriptionContainerView.addSubview(emptyDescriptionLabel)
        emptyDescriptionLabel.anchor(top: emptyDescriptionContainerView.topAnchor, left: emptyDescriptionContainerView.leftAnchor, bottom: emptyDescriptionContainerView.bottomAnchor, right: emptyDescriptionContainerView.rightAnchor, paddingBottom: 28)
        
        setupTargets()
    }
    
    func setupTargets(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
        
        transactionName.textField.addTarget(self, action: #selector(textFieldDidEnd), for: .editingDidEnd)
        
        transactionAmount.textField.addTarget(self, action: #selector(updateTextField), for: .allEditingEvents)
        transactionAmount.textField.sendActions(for: .valueChanged)
        
        transactionDate.textField.textField.addTarget(self, action: #selector(updateDate), for: .allEditingEvents)
        transactionDate.textField.textField.sendActions(for: .valueChanged)
        
        transactionDate.textField.textField.placeholder = "DD/MM/YYYY"
        
        emptyGoalButton.addTarget(self, action: #selector(goToBudgetPlanner), for: .touchUpInside)
    }
    
    func setSelectorPressable(isPressable: Bool = true) {
        if isPressable {
            let tapOpenTypeSelector = UITapGestureRecognizer(target: self, action: #selector(openTypeSelector))
            transactionType.addGestureRecognizer(tapOpenTypeSelector)
            
            let tapOpenSelector = UITapGestureRecognizer(target: self, action: #selector(openSelector))
            transactionBudgetCategory.addGestureRecognizer(tapOpenSelector)
        }
    }
    
    @objc func goToBudgetPlanner(_ sender: UIButton) {
        delegate?.goToBudgetPlanner()
    }
    
    @objc func openSelector() {
        delegate?.openCategoryBudgetSelector()
    }
    
    @objc func openTypeSelector() {
        delegate?.openTypeSelector()
    }
    
    @objc func textFieldDidEnd() {
        delegate?.shouldEnableSaveButton()
    }
    
    @objc func updateTextField() {
        let textField = transactionAmount.textField
        let incomeString = (textField.text ?? "0.0").replacingOccurrences(of: ".", with: "")
        let incomeDouble = Double(incomeString) ?? 0.0
        income = incomeDouble
        
        textField.text = CurrencyHelper.getFormattedNumber(from: incomeDouble)
        delegate?.shouldEnableSaveButton()
    }
    
    @objc func updateDate() {
        let textField = transactionDate.textField.textField
        date = transactionDate.date!
        textField.text = DateFormatHelper.getDDMMyyyy(from: transactionDate.date ?? Date())
        delegate?.shouldEnableSaveButton()
    }
    
    class IconView: UIView {
        let iconTextField: UIEmojiTextField = {
            let tf = UIEmojiTextField()
            tf.font = UIFont.systemFont(ofSize: 80)
            tf.attributedPlaceholder = NSAttributedString(string:"Tambah Icon", attributes:[NSAttributedString.Key.font :UIFont.bodyMedium!, NSAttributedString.Key.foregroundColor:UIColor.royalHunterBlue!])
            tf.textAlignment = .center
            tf.tintColor = .clear
            tf.backgroundColor = .secondary2
            tf.layer.cornerRadius = 75
            tf.layer.masksToBounds = true
            tf.isUserInteractionEnabled = false
            return tf
        }()
        
        let editButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "EditCircle"), for: .normal)
            return button
        }()
        
        func setUp() {
            //auto-layout
            
            addSubview(editButton)
            addSubview(iconTextField)
            bringSubviewToFront(editButton)
            
            editButton.anchor(bottom: iconTextField.bottomAnchor, right: iconTextField.rightAnchor, paddingRight: 15)
            
            iconTextField.centerX(inView: self)
            
            iconTextField.anchor(width: 150, height: 150)
        }
        
    }
}
