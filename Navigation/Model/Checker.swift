//
//  Checker.swift
//  Navigation
//
//  Created by Ульви Пашаев on 13.01.2023.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate {
    func check(_ controller: LogInViewController, login: String, password: String) -> Bool
}

class Checker {
    static let shared = Checker()
    
    private let login: String = "mafia"
    private let password: String = "pass"
    

    func check(login: String, password: String) ->Result< Bool, LoginError> {
        if login == login && password == self.password {
            return .success(true)
        }
        if login == "" && password != "" {
            return .failure(.loginEmpty)
        }
        if login == "" && password == "" {
            return .failure(.empty)
        }
        else {
            return .failure(.incorrect)
        }
    }
    
    private init() {
    }
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(_ controller: LogInViewController, login: String, password: String) -> Bool {
        switch Checker.shared.check(login: login, password: password) {
        case .success(true):
            print ("Login and password - true")
            return true
        case .failure(LoginError.loginEmpty):
            loginAlert(message: "Email field is not entered")
            return false
        case .failure(LoginError.passwordEmpty):
            loginAlert(message: "Password field is not entered")
            return false
        case .failure(LoginError.empty):
            loginAlert(message: "Email and password fields is not entered")
            return false
        case .failure(LoginError.incorrect):
            loginAlert(message: "Incorrect Email and password")
            return false
        case .success(false):
            loginAlert(message: "Unknown error")
            return false
        }
    }
}

    func loginAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
    }

// создаем Factory method
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
    }
    
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
