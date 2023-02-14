//
//  TabBarModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 10.02.2023.
//

import Foundation
import UIKit

// для удобства использования создаем структуру с TabBarItem
struct TabBarItems {
    static var items = [
        UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0),
        UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
    ]
}
