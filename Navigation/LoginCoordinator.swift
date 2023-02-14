//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Ульви Пашаев on 13.02.2023.
//

import Foundation
import UIKit

class LoginCoordinator: CoordinatorProtocol {
    
    var childs: [CoordinatorProtocol] = []
    
    var rootVC: UIViewController?
    
    // MARK: - Methods
    
    func build() -> UIViewController {
        logACtivate()
        let loginVC = LogInViewController()
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
        let loginNavigationController = UINavigationController.init(rootViewController: loginVC)
        loginVC.coordinator = self
        rootVC = loginNavigationController
        return loginNavigationController
    }
    
    func showProfile(user: User) {
        let coordinator = ProfileCoordinator()
        attachChild(coordinator)
        let vc = coordinator.build(user: user)
        rootVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
