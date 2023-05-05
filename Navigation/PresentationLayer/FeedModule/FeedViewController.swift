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
    
    //    создание  по заданию
    var postTitle: PostFeed = PostFeed(title: "Post Title")
    
    // MARK: - Properties
    
    //создание кнопки для просмотра поста
    private var buttonOne: CustomButton = {
        let button = CustomButton(title: Strings.buttonTitle1.localized, backgroundColor: .systemIndigo)
        return button
    }()
    
    // создание второй кнопки
    private var buttonTwo: CustomButton = {
        let button = CustomButton(title: Strings.buttonTitle2.localized, backgroundColor: .systemRed)
        return button
    }()
    
    // текстовое поле для проверки пароля (можно было бы создать еще CustomTextField, но пришлось бы переписывать много кода, поэтому решил сделать так
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.passwordPlaceholder.localized
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // создание кнопки для проверки пароля CheckGuessButton
    private var checkButton: CustomButton = {
        let button = CustomButton(title: Strings.buttonTitle3.localized, backgroundColor: .black)
        return button
    }()
    
    // создание кнопки, которая выводит результат - true/false
    private var resultButton: CustomButton = {
        let button = CustomButton(title: Strings.buttonTitle4.localized, backgroundColor: .systemPink)
        return button
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
//        self.title = "Feed"
        //отображение кнопок на экране
        view.addSubview(stackViewButton)
        // сборка и добавление на экран
        addView()
        addTargetAction()
        setConstraint()
    }
    
    func addView() {
        // объединение кнопок в stackView
        //        stackViewButton.addArrangedSubview(button)
        stackViewButton.addArrangedSubview(buttonOne)
        stackViewButton.addArrangedSubview(buttonTwo)
        stackViewButton.addArrangedSubview(textField)
        stackViewButton.addArrangedSubview(checkButton)
        stackViewButton.addArrangedSubview(resultButton)
        
    }
    
    func addTargetAction() {
        buttonOne.buttonAction = {
            let detailController = PostViewController()
            detailController.titlePost = self.postTitle.title
            self.navigationController?.pushViewController(detailController, animated: false)
        }
        buttonTwo.buttonAction = buttonOne.buttonAction //приравниваем вторую кнопку к первой (все действия идентичны с переходом на PostViewController)
        
        // button проверки пароля
        checkButton.buttonAction = {
            let inputWord = self.textField.text ?? ""
            let result: Bool = FeedModel().check(word: inputWord)
            if result == true {
                self.resultButton.backgroundColor = .systemGreen
                self.resultButton.setTitle(Strings.resultButtonTrue.localized, for: .normal)
            } else {
                self.resultButton.backgroundColor = .systemRed
                self.resultButton.setTitle(Strings.resultButtonFalse.localized, for: .normal)
            }
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
