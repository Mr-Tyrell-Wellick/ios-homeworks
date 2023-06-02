//
//  String.swift
//  Navigation
//
//  Created by Ульви Пашаев on 05.05.2023.
//

import Foundation

// MARK: Navigation TabBar
enum Strings: String {
    case tabBarTitle1 = "tabBarTitle1"
    case tabBarTitle2 = "tabBarTitle2"
    case tabBarTitle3 = "tabBarTitle3"
    case tabBarTitle4 = "tabBarTitle4"
    case tabBarTitle5 = "tabBarTitle5"
    
    // MARK: - Feed Screen
    case buttonTitle1 = "buttonTitle1"
    case buttonTitle2 = "buttonTitle2"
    case passwordPlaceholder = "passwordPlaceholder"
    case buttonTitle3 = "buttonTitle3"
    case buttonTitle4 = "buttonTitle4"
    case resultButtonTrue = "resultButtonTrue"
    case resultButtonFalse = "resultButtonFalse"
    
    // MARK: - Favorite
    case navigationItem1 = "navigationItem1"
    
    // MARK: - Login Screen
    case logInTextField = "logInTextField"
    case passwordTextField = "passwordTextField"
    case logInButton = "logInButton"
    case authButton = "authButton"
    
    // MARK: - TracklistController (Player)
    case navigationItem2 = "navigationItem2"

    // MARK: - ProfileHeaderView
    case statusTextField = "statusTextField"
    case statusButton = "statusButton"

    // MARK: - PhotosTableViewCell
    case photoLabel = "photoLabel"
    
    // MARK: - LogInViewController
    case userNameDebug = "userNameDebug"
    case userNameRelease = "userNameRelease"
    
    var localized: String {
        self.rawValue.localizedString()
    }
}
