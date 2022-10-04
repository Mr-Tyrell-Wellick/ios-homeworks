//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 13.09.2022.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    // создание всплывающего окна(alert) (отображение предупреждающего сообщения)
    let alertController = UIAlertController(title: "Error", message: "Please buy full version of App", preferredStyle: .alert)
    
    //создаем кнопку для закрытия модального окна
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor .white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // создаем кнопку для показа Alert'a
    
    private let buttonAlert: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(button)
        view.addSubview(buttonAlert)
        setupAlertConfiguration()
        
        addConstrait()
        
        // target на закрытие окна
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
        
        // target на открытие showAlert'a
        buttonAlert.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    //метод закрытия модального окна
    @objc func showPostController() {
        self.dismiss(animated: true, completion: nil)
    }
    //метод показа алерта (всплывающего окна)
    @objc func showAlert() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    // метод показа предупреждающего окна
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("only today you can buy it for 10$")
        }))
        alertController.addAction(UIAlertAction(title: "NO Thanks", style: .default, handler: { _ in
            print("Make money and come back")
        }))
        
    }
    
    //MARK: - Constraints
    
    func addConstrait() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
