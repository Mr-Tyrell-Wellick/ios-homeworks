//
//  Color+extension.swift
//  Navigation
//
//  Created by Ульви Пашаев on 06.05.2023.
//

import Foundation
import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in return
            traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
