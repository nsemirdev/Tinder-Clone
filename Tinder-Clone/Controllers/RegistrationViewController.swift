//
//  RegistrationViewController.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 21.12.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let viewModel = RegistrationViewModel()

    // MARK: - UI Elements
    
    let selectPhotoButon: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32, weight: .heavy)
        button.heightAnchor.constraint(equalToConstant: 280).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter full name"
        textField.addTarget(nil, action: #selector(handleTextChanged), for: .editingChanged)
        return textField
    }()
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter email"
        textField.keyboardType = .emailAddress
        textField.addTarget(nil, action: #selector(handleTextChanged), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.addTarget(nil, action: #selector(handleTextChanged), for: .editingChanged)
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        return button
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [selectPhotoButon, fullNameTextField, emailTextField, passwordTextField, registerButton])
    
    // MARK: - Lifecycle
    
    @objc func handleTextChanged(textField: UITextField) {
        if textField == fullNameTextField {
            viewModel.fullName = fullNameTextField.text
        } else if textField == emailTextField {
            viewModel.email = emailTextField.text
        } else {
            viewModel.password = passwordTextField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    fileprivate func setupRegistrationViewModelObserver() {
        viewModel.isFormValidObserver = { isFormValid in
            if isFormValid {
                self.registerButton.isEnabled = true
                self.registerButton.backgroundColor = .systemRed
            } else {
                self.registerButton.isEnabled = false
                self.registerButton.backgroundColor = .lightGray
            }
        }
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let difference = view.frame.height - (stackView.frame.minY + stackView.frame.height)
        view.transform = CGAffineTransform(translationX: 0, y: -(frame.cgRectValue.height - difference) - 20)
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .systemBackground
        setupGradiantLayer()
        
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32 ),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupGradiantLayer() {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
        gradiantLayer.locations = [0, 1]
        gradiantLayer.frame = view.frame
        view.layer.addSublayer(gradiantLayer)
    }
    
}
