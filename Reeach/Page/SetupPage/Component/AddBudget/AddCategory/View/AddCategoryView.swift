//
//  AddCategoryView.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class AddCategoryView: UIView {
    weak var viewDelegate: AddCategoryViewDelegate?
    weak var viewController: AddCategoryViewController?
    weak var navigationBarDelegate: NavigationBarDelegate?
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
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
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "EditCircle"), for: .normal)
        button.anchor(width: 34, height: 34)
        return button
    }()
    
    lazy var nameTextField = {
        let textField = TextField(frame: .zero, title: "Nama Kategori", style: .template)
        textField.textField.placeholder = "Nama kategori di sini"
        textField.textField.delegate = self
        return textField
    }()
    
    lazy var saveButton = Button(style: .rounded, foreground: .primary, background: .tangerineYellow, title: "Simpan")
    
    lazy var backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(back(_:)))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red6 as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        
        return barButtonItem
    }()
    
    func configureView(viewController: AddCategoryViewController) {
        backgroundColor = .ghostWhite
        
        viewDelegate = viewController
        self.viewController = viewController
        
        configureButtonColor()
        configureNavigationControllerView()
        configureAutoLayout()
        configureClickableTarget()
    }
    
    func configureNavigationControllerView() {
        navigationBarDelegate = viewController
        viewController?.navigationItem.leftBarButtonItem = backButton
    }
    
    func configureAutoLayout() {
        let viewMargins = safeAreaLayoutGuide

        addSubview(stackView)
        stackView.anchor(top: viewMargins.topAnchor, left: viewMargins.leftAnchor, bottom: viewMargins.bottomAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 28)
        stackView.widthAnchor.constraint(equalTo: viewMargins.widthAnchor, constant: -40).isActive = true

        stackView.addArrangedSubview(iconContainerView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(saveButton)

        iconContainerView.addSubview(backgroundView)
        backgroundView.centerX(inView: iconContainerView)
        backgroundView.anchor(top: iconContainerView.topAnchor, bottom: iconContainerView.bottomAnchor)
        
        iconContainerView.addSubview(iconTextField)
        iconTextField.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor)
        
        iconContainerView.addSubview(editButton)
        editButton.anchor(bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor)
    }
    
    @objc func back(_ animated: Bool) {
        navigationBarDelegate?.cancel()
    }
    
    func configureClickableTarget() {
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        iconTextField.addTarget(self, action: #selector(textFieldDidEndOnExit), for: .editingDidEndOnExit)
        nameTextField.textField.addTarget(self, action: #selector(textFieldDidEndOnExit), for: .editingDidEndOnExit)
    }
    
    @objc func edit(_ sender: UIButton) {
        iconTextField.isUserInteractionEnabled = true
        iconTextField.becomeFirstResponder()
    }
    
    @objc func save(_ sender: UIButton) {
        guard let icon = iconTextField.text,
              let name = nameTextField.textField.text
        else { return }
        
        guard icon != "" && name != ""
        else { return }
        
        viewDelegate?.save(icon: icon, name: name)
    }
    
    @objc func textFieldDidEndOnExit(_ sender: UITextField)
    {
        dismissKeyboard()
    }
    
    func configureButtonColor() {
        var filled = false
        
        if iconTextField.text != "" && nameTextField.textField.text != "" {
            filled = true
        }
        
        saveButton.backgroundColor = filled == true ? .primary : .black4
        saveButton.setTitleColor(filled == true ? .black13 : .black7, for: .normal)
    }
}
