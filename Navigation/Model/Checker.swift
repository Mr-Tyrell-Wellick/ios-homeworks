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
    
    func check(login: String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }
    
    private init() {
    }
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(_ controller: LogInViewController, login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
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
