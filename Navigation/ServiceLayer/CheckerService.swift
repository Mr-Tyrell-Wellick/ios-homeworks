//
//  CheckerService.swift
//  Navigation
//
//  Created by Ульви Пашаев on 20.03.2023.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    
    // проверка зарегистрированного пользователя
    func checkCredentials(login: String, password: String, completion: @escaping (String) -> Void)
    // регистрация нового пользователя
    func signUp(login: String, password: String, completion: @escaping (String) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(login: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let res = result {
                    completion(res)
                }
            } else {
                completion("Success authorization")
            }
        }
    }
    
    // Реализуем метод signUp для создания новой учетной записи
    func signUp(login: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let res = result {
                    completion(res)
                }
            } else {
                completion("Successful registration")
            }
        }
    }
}

//Пароль для входа
//321@gmail.com
//q12345
