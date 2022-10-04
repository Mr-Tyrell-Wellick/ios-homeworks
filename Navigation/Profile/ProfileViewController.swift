//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 10.09.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    // создаем экземпляр класса ProfileHeaderView
    let profileView: UIView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    
    //добавление кнопки по заданию
    private let newButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Button", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        //target на кнопку
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = "Profile"
        
        view.addSubview(profileView)
        view.addSubview(newButton)
        
        addConstraint()
    }
    
    @objc func pressButton() {
        print("button capability")
    }
    
    // MARK: - constraints
    
    func addConstraint() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileView.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 0),
            profileView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: 0),
            profileView.heightAnchor.constraint(equalToConstant: 220),
            
            newButton.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 0),
            newButton.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            newButton.bottomAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            newButton.widthAnchor.constraint(equalToConstant: 340),
            newButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
