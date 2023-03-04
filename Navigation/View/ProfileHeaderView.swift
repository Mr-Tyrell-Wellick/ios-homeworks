//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ульви Пашаев on 16.09.2022.
//

import Foundation
import UIKit

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
    
    // текстовое поле для ввода текста статуса
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
    
    // настройка статуса. Присваиваем новые значения статуса, имени и аватарки, используя новый класс User.
    func setupStatus(user: User) {
        fullNameLabel.text = user.userName
        statusLabel.text = user.status
        avatarImageView.image = user.avatar
    }
    
    func addViews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }

    @objc func buttonPressed() {
        do {
            try newStatus()
        } catch StatusError.emptyStatus {
            statusAlert(message: "Сannot change the status, because there is no text in the input field")
            
        } catch StatusError.longStatus {
            statusAlert(message: "Status text is too long. \nMaximum number of characters allowed: 30")
            
        } catch {
            statusAlert(message: "Unexpected error")
        }
    }
    
    func newStatus() throws {
        
        guard statusText != "" else {
            throw StatusError.emptyStatus
        }
        guard statusText.count < 30 else {
            throw StatusError.longStatus
        }
        statusLabel.text = statusText
        
    }
    //alert and action для кнопки статуса (упакуем ее в функцию)
            func statusAlert(message: String) {
                let alertStatus = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alertStatus.addAction(action)
                UIApplication.topViewController()!.present(alertStatus, animated: true, completion: nil)
            }
    
    @objc func changeStatusText() {
        if let text = statusTextField.text {
            statusText = text
        }
    }
    
    // MARK: - Constraints
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            //аватарка
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            //имя лейбла
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            
            //сам статус
            statusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 54),
            statusLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            
            //текст, который будет писаться в статус
            statusTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            statusTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            //кнопка для показа нового статуса
            setStatusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 132),
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            setStatusButton.widthAnchor.constraint(equalToConstant: 340),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.bottomAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 30)
        ])
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
