//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ульви Пашаев on 16.09.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    
    var statusText: String = ""
    //кнопка для показа нового статуса
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 30, y: 240, width: 350, height: 50))
        button.setTitle("Show Status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        //shadow parameters:
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.shadowOpacity = 0.7
      
        //target на кнопку
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    // Имя пользователя
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 90, width: 200, height: 100))
        label.text = "Lalo Salamanca"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-bold", size: 18.0)
        return label
    }()
    //сам статус
    private let statusLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 145, y: 145, width: 300, height: 50))
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        return label
    }()
    //аватарка
    private let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        image.image = UIImage(named: "Lalo")
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    // текст, который будет писаться в статус
    private let textFiled: UITextField = {
        let textField = UITextField(frame: CGRect(x: 135, y: 190, width: 220, height: 40))
        textField.placeholder = "Enter text here"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        //target
        textField.addTarget(self, action: #selector(changeStatusText), for: .editingChanged)
        return textField
    }()
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //MARK: - Methods
    
    func addViews() {
        addSubview(button)
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(image)
        addSubview(textFiled)
    }
    
    
    @objc func buttonPressed() {
        if let text = statusLabel.text {
            print(text)
        }
        if statusText != "" {
            statusLabel.text = statusText
        }
    }
    
    @objc func changeStatusText() {
        if let text = textFiled.text {
            statusText = text
        }
        
        
        
        

        
        //        @objc func changeStatusText(_ textField: UITextField){
        //            if let text = textField.text {
        //                statusText = text
        //            }
                


    }
}
    
