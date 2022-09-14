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
        let label = UILabel(frame: CGRect(x: 160, y: 40, width: 350, height: 100))
        label.textColor = .black
        return label
    }()
    



    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(titleLabel)
        titleLabel.text = titlePost
    }
}
