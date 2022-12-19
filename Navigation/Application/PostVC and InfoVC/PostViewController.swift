//
//  PostViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 12.09.2022.
//

import Foundation
import UIKit


class PostViewController: UIViewController {
    
    // создаем переменную для текста заголовка, куда будет передаваться заголовок из FeedViewController
    var titlePost: String = ""
    
    // создаем заголовок без текста
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //меняем заголовок на вновь пришедший
        self.title = titlePost
        
        // создаем UIBarButtonItem c 1 контейнером
        
        let modalItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modalItem]
    }
    
    // функция обработки нажатия на кнопку
    @objc func showModal() {
        let popUpViewController = InfoViewController()
        popUpViewController.modalPresentationStyle = .fullScreen
        self.present(popUpViewController, animated: true, completion: nil)
        
    }
}
