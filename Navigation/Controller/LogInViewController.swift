//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 15.10.2022.
//

import Foundation
import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    // создаем свойство loginDelegate c типом LoginViewControllerDelegate, который будет проверять значения, введенные в текстовые поля контроллера (login and password)
    var loginDelegate: LoginViewControllerDelegate?
    
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
        button.addTarget(self, action: #selector(showProfileView), for: .touchUpInside)
        return button
    }()
    
    // создание кнопки для ввода email or phone
    private let logInTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.textColor = .black
        //        textField.text = "mafia"
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
        //        textField.text = "pass"
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
        
        // создаем action для alert'a
        //        alertController.addAction(UIAlertAction(title: "Попробовать снова", style: .default))
        
    }
    
    // создаем alert в случае неверного ввода логина
    //    let alertController = UIAlertController(title: "Ошибка ввода", message: "Логин введен неверно", preferredStyle: .alert)
    
    //функция нажатия на клавишу Log In открывает ProfileView (p.s. внесены изменения. Согласно заданию, если debug - версия, то отображается один контент, если release - версия, то другой контент)
    
    
    //MARK: - authorization and alerts
    
    // Функция для проверки доступа пользователя
    func checkAccess(login: String, password: String) throws {
        
        // Вызов метода делегата, который проверяет правильность ввода логина и пароля
        if(loginDelegate?.check(self, login: login, password: password)) == false {
            throw AuthorizationError.userNotFound
        }
    }
    // Функция для вывода сообщения об ошибке при неверном вводе пароля
    func badAlertPassword(message: String) {
        let badAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        badAlert.addAction(UIAlertAction(title: "Try again", style: .default))
        self.present(badAlert, animated: true, completion: nil)
    }
    
    // Функция для вывода сообщения об успешной операции
    func goodAlert(message: String) {
        let goodAlert = UIAlertController(title: "Well done", message: message, preferredStyle: .alert)
        goodAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(goodAlert, animated: true, completion: nil)
    }
    // Функция для вывода сообщения об ошибке при неверном вводе логина
    // Возвращает результат в замыкании
    func badAlertLogin(message: String, completion: @escaping (Bool) -> Void) {
        let badAlert = UIAlertController(title: "User not found", message: "Do you want to create a new account?", preferredStyle: .alert)
        badAlert.addAction(UIAlertAction(title: "Register", style: .default, handler: { action in
            completion(true)
        }))
        badAlert.addAction(UIAlertAction(title: "Try again", style: .default))
        self.present(badAlert, animated: true, completion: nil)
    }
    
    //нажатие на кнопку Log In
    @objc func showProfileView() {
        
        // текст, который вводит пользователь в первую строку (где указывается логин)
        let enteredUserLogin = logInTextField.text!
        // текст, который вводит пользователь во вторую строку (где указывается пароль)
        let enteredPassword = passwordTextField.text!
        
#if DEBUG
        
        let userLogin = TestUserService(user: User(userName: "Eduardo Salamanca", avatar: UIImage(named: "LaloForTest") ?? UIImage(), status: "If you need a lawer - Better Call Saul!"))
#else
        let userLogin = CurrentUserService(user: User(userName: "Lalo Salamanca", avatar: UIImage(named: "Lalo") ?? UIImage(), status: "I am the boss"))
#endif
        
        // Проверяем введенные учетные данные с помощью сервиса CheckerService и обрабатываем результат с помощью блока closure
        CheckerService().checkCredentials(login: enteredUserLogin, password: enteredPassword) { result in
            if result == "Success authorization" {
                let profileViewController = ProfileViewController()
                profileViewController.user_1 = userLogin.user
                self.navigationController?.pushViewController(profileViewController, animated: true)
            } else if result == "There is no user record corresponding to this identifier. The user may have been deleted." {
                self.badAlertLogin(message: result) { result in
                    CheckerService().signUp(login: enteredUserLogin, password: enteredPassword) { result in
                        if result == "Success registration" {
                            self.goodAlert(message: result)
                            
                        } else {
                            self.badAlertPassword(message: result)
                        }
                    }
                }
            } else {
                self.badAlertPassword(message: result)
            }
        }
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
        print("Hide keyboard")
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

