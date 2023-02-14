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
// убирает из массива
public extension Array {
    mutating func removeElementByReference(_ element: Element) {
        guard let objIndex = firstIndex(where: { $0 as AnyObject === element as AnyObject }) else {
            return
        }
        remove(at: objIndex)
    }
}
