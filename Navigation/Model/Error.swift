//
//  Error.swift
//  Navigation
//
//  Created by Ульви Пашаев on 04.03.2023.
//

import Foundation
import UIKit

// перечисление ошибок в логине
enum LoginError: Error {
    case incorrect
    case loginEmpty
    case passwordEmpty
    case empty
}

// перечисление ошибок в статусе
enum StatusError: Error {
    case emptyStatus
    case longStatus
}

// перечисление ошибок в авторизации
enum AuthorizationError: Error {
    case userNotFound
}
