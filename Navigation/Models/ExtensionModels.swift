//
//  ExtensionModels.swift
//  Navigation
//
//  Created by Ульви Пашаев on 02.11.2022.
//

import Foundation
import UIKit

extension UIView {
    
func applyBlurEffect(_ bEffect: UIBlurEffect? = nil, style: UIBlurEffect.Style = .extraLight) {
    let blurEffect = bEffect == nil ? UIBlurEffect(style: style) : bEffect
    let vissualEffectView = UIVisualEffectView(effect: blurEffect)
    vissualEffectView.frame = bounds
    vissualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(vissualEffectView)
}

func removeBlurEffect() {
    let bluredEffectView = self.subviews.filter {$0 is UIVisualEffectView}
        bluredEffectView.forEach { blurView in
            blurView.removeFromSuperview()
        }
    }
}

// создаем extension для того, чтобы можно было использовать presented даже за прелами контроллера
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabBarController = controller as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
            }
        return controller
        }
    }
