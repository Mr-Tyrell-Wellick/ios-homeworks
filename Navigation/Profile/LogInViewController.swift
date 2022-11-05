//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 15.10.2022.
//

import Foundation
import UIKit


class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //    создание VK лого
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //    создание кнопки "Log In"
    private let logInbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "Blue_pixel")
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        //target на кнопку
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
        //поменять функцию таргета!!!! Потому что кнопка должна переключать на другой экран
    }()
    
    // создание кнопки для ввода email or phone
    
    private let logInTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.textColor = .black
        //        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = .systemFont(ofSize: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // согласно макету есть разделить между полями для ввода
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    
    // создание кнопки для ввода password
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.font = .systemFont(ofSize: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // stackView для полей ввода данных
    
    private let stackViewTextField: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.navigationController?.navigationBar.isHidden = true
        
        addView()
        addConstraints()
        
    }
    
    // MARK: - добавление view
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        
        stackViewTextField.addArrangedSubview(logInTextField)
        stackViewTextField.addArrangedSubview(line)
        stackViewTextField.addArrangedSubview(passwordTextField)
        
        scrollView.addSubview(stackViewTextField)
        scrollView.addSubview(logInbutton)
        
    }
    
    //функция нажатия на клавишу Log In
    @objc func pressButton() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    // MARK: - KEYBOARD (вся работа с клавиатурой)
    
    //процесс открытия и закрытия клавиатуры
    
    
    //метод обработки тапа и сокрытия клавиатуры
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // наблюдатели - появление и исчезновение клавиатуры
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // скрытие клавиатуры, расчет и определение перекрытия
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        print("Show keyboard")
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            // формула расчета перекрытия кнопки клавиатурой
            
            let loginButtonBottomPointY = self.logInbutton.frame.origin.y + logInbutton.frame.height
            
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 32
            : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    // функция сокрытия клавиатуры
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    // MARK: - constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackViewTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackViewTextField.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            stackViewTextField.heightAnchor.constraint(equalToConstant: 100),
            
            logInTextField.heightAnchor.constraint(equalToConstant: 49.75),
            logInTextField.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            logInTextField.leftAnchor.constraint(equalTo: stackViewTextField.leftAnchor, constant: 0),
            
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            line.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 49.75),
            passwordTextField.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: stackViewTextField.leftAnchor, constant: 0),
            
            logInbutton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInbutton.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            logInbutton.heightAnchor.constraint(equalToConstant: 50),
            logInbutton.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
        ])
    }
}

