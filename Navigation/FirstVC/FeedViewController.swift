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


class UserTabVC: UIViewController {
    
//    создание  по заданию
    var postTitle = Post(title: "Post Title")
    
    
    
    // MARK: - Properties
    
    private let titleLable: UILabel = {
        let label = UILabel(frame: CGRect(x: 180, y: 40, width: 350, height: 100))
        label.text = "Feed"
        label.textColor = .black
        return label
    }()
 
    private let descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 160, y: 150, width: 350, height: 100))
        label.textColor = .systemGray
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 160, y: 450, width: 95, height: 35))
        button.setTitle("View Post", for: .normal)
        button.setTitleColor(UIColor .black, for: .normal)
        button.backgroundColor = .gray
        return button
    }()


    // MARK: - Methods

override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(titleLable)
    view.addSubview(descriptionLabel)
    view.addSubview(button)
    addTarget()
    view.backgroundColor = .white
}

    // target на кнопку
    
    func addTarget() {
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
    }
    
    
    // функция обработки нажатия на кнопку
    @objc func showPostController() {
        let detailController = PostViewController()
        detailController.titlePost = postTitle.title
        navigationController?.pushViewController(detailController, animated: false)
    }
    
    }


