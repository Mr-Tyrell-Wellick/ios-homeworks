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
    func checkCredentials(
        login: String,
        password: String,
        completion: @escaping (CheckerServiceAuthResult) -> Void
    )
    
    // регистрация нового пользователя
    func signUp(
        login: String,
        password: String,
        completion: @escaping (CheckerServiceSignUpResult) -> Void
    )
}

enum CheckerServiceAuthResult {
    case success
    case error(String)
}

enum CheckerServiceSignUpResult {
    case success
    case error(String)
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(
        login: String,
        password: String,
        completion: @escaping (CheckerServiceAuthResult) -> Void
    ) {
        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let result {
                    completion(.error(result))
                }
            } else {
                completion(.success)
            }
        }
    }
    
    // реализуем метод signUp для создания новой учетной записи
    func signUp(
        login: String,
        password: String,
        completion: @escaping (CheckerServiceSignUpResult) -> Void
    ) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let result {
                    completion(.error(result))
                }
            } else {
                completion(.success)
            }
        }
    }
}
