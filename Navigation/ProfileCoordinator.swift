//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Ульви Пашаев on 12.02.2023.
//

import Foundation
import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    var childs: [CoordinatorProtocol] = []
    
    private var rootVC: UIViewController?
    
    // MARK: - Methods
    func build(user: User) -> UIViewController {
        logACtivate()
        let profileVc = ProfileViewController()
        profileVc.user_1 = user
        rootVC = profileVc
        return profileVc
    }
}
