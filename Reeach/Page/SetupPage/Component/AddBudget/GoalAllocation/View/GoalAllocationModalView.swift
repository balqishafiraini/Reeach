//
//  GoalAllocationModalView.swift
//  Reeach
//
//  Created by Balqis on 14/11/22.
//

import Foundation
import UIKit

class GoalAllocationModalView: UIView {
    weak var viewDelegate: GoalAllocationModalViewDelegate?
    weak var navigationBarDelegate: NavigationBarDelegate?
    weak var viewController: GoalAllocationModalViewController?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
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
            string: "Tambah Icon",
            attributes: [
                NSAttributedString.Key.font: UIFont.bodyMedium as Any,
                NSAttributedString.Key.foregroundColor: UIColor.secondary7 as Any
            ]
        )
        emojiTextField.tintColor = .clear
        emojiTextField.textAlignment = .center
        emojiTextField.isUserInteractionEnabled = false
        emojiTextField.translatesAutoresizingMaskIntoConstraints = false
        emojiTextField.delegate = self
        return emojiTextField
    }()
    
    lazy var goalNameTextField = {
        let textField = TextField(frame: .zero, title: "Judul", style: .template)
        textField.isUserInteractionEnabled = false
        textField.textField.placeholder = ""
        return textField
    }()
    
    lazy var dueDateDatePicker = {
        let datePicker = DatePicker(frame: .zero, title: "Deadline")
        datePicker.datePicker.minimumDate = Date()
        return datePicker
    }()
    
    lazy var targetAmountTextField = TextField(frame: .zero, title: "Target Terkumpul", style: .template, prefix: "Rp")
    
    lazy var inflationButton: UIButton = {
        let button = UIButton()
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.imageView?.heightAnchor.constraint(equalTo: button.titleLabel?.heightAnchor ?? button.heightAnchor).isActive = true
        button.imageView?.widthAnchor.constraint(equalTo: button.imageView!.heightAnchor).isActive = true
        button.tintColor = .royalHunterBlue
        button.setTitle("Nilai setelah inflasi: ", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        button.setTitleColor(.royalHunterBlue, for: .normal)
        button.titleLabel?.font = .caption1Bold
        button.titleLabel?.textAlignment = .left
        button.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        return button
    }()
    
    lazy var monthlyAllocationTextField = TextField(frame: .zero, title: "Tabungan Bulanan", style: .template, prefix: "Rp")
    
    lazy var remainingLabel: UILabel = {
        let label = UILabel()
        label.text = "Sisa anggaran yang harus dialokasikan"
        label.numberOfLines = 0
        label.textColor = .black13
        label.font = .caption1Medium
        return label
    }()
    
    lazy var recommendationVerticalStackViewContainerView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .red1
        return view
    }()

    private lazy var recommendationVerticalStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private lazy var recommendationHorizontalStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }()

    lazy var showHideButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.anchor(width: 22)
        button.setImage(UIImage(named: "DownRed"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    lazy var recommendationHeaderLabel = {
        let label = UILabel()
        label.text = """
            YUK REVISI GOALSNYA YUK!
            
            Pake strategi ini goalsnya akan sulit kamu capai nih.
            """
        label.numberOfLines = 0
        label.font = UIFont.caption1Bold
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var recommendationDetailLabel = {
        let label = UILabel()
        label.text = """
            Worry not. Stay calm, stay slay. Ini ada beberapa rekomendasi yang bisa kamu ikuti untuk mencapai goalsmu:
            
            1. Ubah deadline menjadi 08/25, atau
            2. Ubah jumlah tujuan menjadi Rp1.517.036,84, atau
            3. Ubah alokasi bulanan menjadi Rp197.753,93
            """
        label.numberOfLines = 0
        label.font = UIFont.caption1Medium
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    lazy var blankView = UIView()
    lazy var blankViewHeightConstraint = blankView.heightAnchor.constraint(equalToConstant: 0)
    
    lazy var deleteButton = {
        let btn = Button(style: .rounded, foreground: .destructive, background: .darkSlateGrey, title: "Hapus Kebutuhan")
        btn.backgroundColor = .red6
        btn.setTitleColor(UIColor.ghostWhite, for: .normal)
        return btn
    }()
    
    lazy var saveButton = {
        let btn = Button(style: .rounded, foreground: .primary, background: .darkSlateGrey, title: "Simpan")
        btn.backgroundColor = .black4
        btn.setTitleColor(UIColor.black7, for: .normal)
        return btn
    }()
    
    func configureStackView(viewContoller: GoalAllocationModalViewController) {
        backgroundColor = .ghostWhite
        
        self.viewController = viewContoller
        viewDelegate = viewController
        navigationBarDelegate = viewController
        setupAddTargetIsNotEmptyTextFields()
        hideKeyboardWhenTappedAround()
        setNavigationBar()
        
        dueDateDatePicker.textField.textField.delegate = self
        monthlyAllocationTextField.textField.delegate = self
        targetAmountTextField.textField.delegate = self
        
        dueDateDatePicker.textField.textField.delegate = self
        monthlyAllocationTextField.textField.keyboardType = .numberPad
        targetAmountTextField.textField.keyboardType = .numberPad
        
        inflationButton.addTarget(self, action: #selector(inflationButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteBudget), for: .touchUpInside)
        showHideButton.addTarget(self, action: #selector(showHide), for: .touchUpInside)
        
        addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
        
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, paddingTop: 20, paddingLeft: 20)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        stackView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: -40).isActive = true
        
        stackView.addArrangedSubview(iconContainerView)
        stackView.addArrangedSubview(goalNameTextField)
        stackView.addArrangedSubview(dueDateDatePicker)
        stackView.addArrangedSubview(targetAmountTextField)
        stackView.addArrangedSubview(inflationButton)
        stackView.addArrangedSubview(monthlyAllocationTextField)
        stackView.addArrangedSubview(remainingLabel)
        stackView.addArrangedSubview(recommendationVerticalStackViewContainerView)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(deleteButton)
        stackView.addArrangedSubview(blankView)
        
        stackView.setCustomSpacing(8, after: targetAmountTextField)
        stackView.setCustomSpacing(8, after: monthlyAllocationTextField)
        
        iconContainerView.addSubview(backgroundView)
        backgroundView.centerX(inView: iconContainerView)
        backgroundView.anchor(top: iconContainerView.topAnchor, bottom: iconContainerView.bottomAnchor)
        
        iconContainerView.addSubview(iconTextField)
        iconTextField.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor)
        
        recommendationVerticalStackViewContainerView.addSubview(recommendationVerticalStackView)
        recommendationVerticalStackView.anchor(top: recommendationVerticalStackViewContainerView.topAnchor, left: recommendationVerticalStackViewContainerView.leftAnchor, bottom: recommendationVerticalStackViewContainerView.bottomAnchor, right: recommendationVerticalStackViewContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)

        recommendationVerticalStackView.addArrangedSubview(recommendationHorizontalStackView)
        recommendationVerticalStackView.addArrangedSubview(recommendationDetailLabel)

        recommendationHorizontalStackView.addArrangedSubview(recommendationHeaderLabel)
        recommendationHorizontalStackView.addArrangedSubview(showHideButton)
        
        blankViewHeightConstraint.isActive = true
    }
    
    func setNavigationBar() {
        let doneItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(dismissView))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        doneItem.setTitleTextAttributes(attributes, for: .normal)
        
        viewController?.navigationItem.leftBarButtonItem = doneItem
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        saveButton.isEnabled = false
        [targetAmountTextField.textField, monthlyAllocationTextField.textField].forEach({ $0.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged) })
    }
    
    @objc func textFieldsIsNotEmpty(_ sender: UITextField) {
        viewDelegate?.updateDynamicView()
        
        guard let saving = monthlyAllocationTextField.textField.text, !saving.isEmpty,
              let totalAmount = targetAmountTextField.textField.text, !totalAmount.isEmpty,
              let goalDueDate = dueDateDatePicker.textField.textField.text, !goalDueDate.isEmpty
        else {
            saveButton.backgroundColor = .black4
            saveButton.setTitleColor(UIColor.black7, for: .normal)
            saveButton.isEnabled = false
            return
        }
        
        viewDelegate?.disableButtonIfNotAchivable()
    }
    
    @objc func inflationButtonTapped(_ sender: UIButton) {
        viewDelegate?.goToInflationDetail()
    }
    
    @objc func dismissView() {
        navigationBarDelegate?.cancel()
    }
    
    @objc func save(_ sender: UIButton) {
        let dueDate = dueDateDatePicker.date ?? Date()
        let targetAmount = Double(targetAmountTextField.textField.text ?? "0.0") ?? 0
        let monthlyAllocation = Double(monthlyAllocationTextField.textField.text ?? "0.0") ?? 0
        viewDelegate?.save(dueDate: dueDate, targetAmount: targetAmount, montlyAllocation: monthlyAllocation)
    }
    
    @objc func deleteBudget(_ sender: UIButton) {
        viewDelegate?.delete()
    }
    
    @objc func showHide(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "DownRed") {
            sender.setImage(UIImage(named: "UpRed"), for: .normal)
        }
        else if sender.imageView?.image == UIImage(named: "UpRed") {
            sender.setImage(UIImage(named: "DownRed"), for: .normal)
        }
        else if sender.imageView?.image == UIImage(named: "DownGreen") {
            sender.setImage(UIImage(named: "UpGreen"), for: .normal)
        }
        else if sender.imageView?.image == UIImage(named: "UpGreen") {
            sender.setImage(UIImage(named: "DownGreen"), for: .normal)
        }
        recommendationDetailLabel.isHidden.toggle()
    }
}

