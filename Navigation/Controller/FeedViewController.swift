//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 10.09.2022.
//

import Foundation
import UIKit

struct PostFeed {
    var title: String
}

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    // binding во ViewController
    var viewModel = FeedViewModel()
    
    //    создание  по заданию
    var postTitle: PostFeed = PostFeed(title: "Post Title")
    
    // MARK: - Properties
    
    //создание кнопки для просмотра поста
    private var buttonOne: CustomButton = {
        let button = CustomButton(title: "View Post", backgroundColor: .systemIndigo)
        return button
    }()
    
    // создание второй кнопки
    private var buttonTwo: CustomButton = {
        let button = CustomButton(title: "Second View Post", backgroundColor: .systemRed)
        return button
    }()
    
    // текстовое поле для проверки пароля (можно было бы создать еще CustomTextField, но пришлось бы переписывать много кода, поэтому решил сделать так
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // создание кнопки для проверки пароля CheckGuessButton
    private var checkButton: CustomButton = {
        let button = CustomButton(title: "Check secret word", backgroundColor: .black)
        return button
    }()
    
    // создание лейбла, которая выводит результат - true/false
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = UIFont(name: "systemFont", size: 18.0)
        label.layer.cornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    // создаем стеквью
    private let stackViewButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Feed"
        //отображение кнопок на экране
        view.addSubview(stackViewButton)
        // сборка и добавление на экран
        addView()
        addTargetAction()
        setConstraint()
        bindViewModel()
        navigationController?.tabBarItem = TabBarItems.items[0]
    }
    
    func addView() {
        // объединение кнопок в stackView
        stackViewButton.addArrangedSubview(buttonOne)
        stackViewButton.addArrangedSubview(buttonTwo)
        stackViewButton.addArrangedSubview(textField)
        stackViewButton.addArrangedSubview(checkButton)
        stackViewButton.addArrangedSubview(resultLabel)
        
    }
    // binding
    func bindViewModel() {
        viewModel.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.resultLabel.text = statusText
            }
        })
    }
    
    private func checkPassword() {
        if viewModel.checkPass(word: textField.text ?? "") == true {
            print("True")
            self.resultLabel.backgroundColor = .systemGreen
        } else {
            print("False")
            self.resultLabel.backgroundColor = .systemRed
        }
    }
    
    func addTargetAction() {
        buttonOne.buttonAction = {
            self.coordinator?.showPostScreen(title: self.postTitle.title)
        }
        buttonTwo.buttonAction = buttonOne.buttonAction //приравниваем вторую кнопку к первой (все действия идентичны с переходом на PostViewController)
        
        // button проверки пароля
        checkButton.buttonAction = {
            self.checkPassword()
            
        }
    }
    // MARK: - constraints
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            stackViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
