//
//  User.swift
//  Navigation
//
//  Created by Ульви Пашаев on 04.01.2023.
//

import Foundation
import UIKit

// создание протокола UserService с методом проверки ввода логина. Если неверно указать, то пользователь не будет авторизован
protocol UserService {
    func checkLogin(login: String) -> User?
}

//Добавление класса User
class User {
    var login: String
    var userName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, userName: String, avatar: UIImage, status: String) {
        self.login = login
        self.userName = userName
        self.avatar = avatar
        self.status = status
    }
}

//создание класса, поддерживающего протокол UserService
class CurrentUserService: UserService {
    
    let user: User
    func checkLogin(login: String) -> User? {
        return user.login == login ? user : nil
    }
    
    init(user: User) {
        self.user = user
    }
}

// добавляем новый класс TestUserService для debug - версии
class TestUserService: UserService {
    
    let user: User
    func checkLogin(login: String) -> User? {
        return user.login == login ? user : nil
    }
    
    init(user: User) {
        self.user = user
    }
}
