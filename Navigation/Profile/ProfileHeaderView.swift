//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ульви Пашаев on 16.09.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var statusText: String = ""
    
    //аватарка
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Lalo")
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    // Имя пользователя
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lalo Salamanca"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //сам статус
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // текст, который будет писаться в статус
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text here"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        //target на кнопку
        textField.addTarget(self, action: #selector(changeStatusText), for: .editingChanged)
        return textField
    }()
    
    //кнопка для показа нового статуса
    private let setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        //shadow parameters:
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        //target на кнопку
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
        addGestures()
        addNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Methods
    
    func addViews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
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
        if let text = statusTextField.text {
            statusText = text
        }
    }
    
    // MARK: - Constraints (с использованием SnapKit)
    func addConstraints() {
        
        //аватарка
        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(100)
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(16)
        }
        // имя лейбла
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(27)
            make.left.equalTo(self.snp.left).offset(140)
        }
        // сам статус
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(54)
            make.left.equalTo(self.snp.left).offset(140)
        }
        //текст, который будет писаться в статус
        statusTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.equalTo(self.snp.left).offset(140)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(40)
        }
        //кнопка для показа нового статуса
        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(132)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(50)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
    }
    
    //MARK: - Работа с аватаркой
    
    // гестура на клик аватарки
    func addGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        self.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addNotifications() {
        //уведомление о закрытии
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didTapClose(notification:)),
                                               name: Notification.Name("close"),
                                               object: nil)
    }
    // действия при тапе на аватарку
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        //уведомляем о тапе по аватарке
        NotificationCenter.default.post(name: Notification.Name("Avatar Tap"), object: nil)
        // сокрытие оригинала аватарки при клике
        avatarImageView.isHidden = true
        
    }
    // В случае получения уведомления выполняем
    @objc func didTapClose(notification: Notification) {
        avatarImageView.isHidden = false
    }
}
