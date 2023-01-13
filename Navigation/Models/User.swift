//
//  User.swift
//  Navigation
//
//  Created by Ульви Пашаев on 04.01.2023.
//

import Foundation
import UIKit

//Добавление класса User
class User {
    var userName: String
    var avatar: UIImage
    var status: String
    
    init(userName: String, avatar: UIImage, status: String) {
        self.userName = userName
        self.avatar = avatar
        self.status = status
    }
}

//создание класса, поддерживающего протокол UserService
class CurrentUserService {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}

// добавляем новый класс TestUserService для debug - версии
class TestUserService {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
