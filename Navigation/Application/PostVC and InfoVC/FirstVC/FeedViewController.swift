//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 10.09.2022.
//

import Foundation
import UIKit

struct Post {
    var title: String
}

class FeedViewController: UIViewController {
    
    //    создание  по заданию
    
    var postTitle: Post = Post(title: "Post Title")
    
    // MARK: - Properties
    
    
    //создание кнопки для просмотра поста
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("View Post", for: .normal)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        // target на кнопку
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
        return button
    }()
    
    
    // создание второй кнопки
    
    private let buttonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Second View Post", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //target на вторую кнопку
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
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
        self.title = "Feed"
        //отображение кнопок на экране
        view.addSubview(stackViewButton)
        // сборка и добавление на экран
        addView()
        setConstraint()
    }
    
    
    func addView() {
        // объединение кнопок в stackView
        stackViewButton.addArrangedSubview(button)
        stackViewButton.addArrangedSubview(buttonTwo)
    }
    
    // MARK: - constraints
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            stackViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // функция обработки нажатия на кнопку
    @objc func showPostController() {
        let detailController = PostViewController()
        detailController.titlePost = postTitle.title
        navigationController?.pushViewController(detailController, animated: false)
    }
}


