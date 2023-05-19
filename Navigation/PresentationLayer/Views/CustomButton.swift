//
//  CustomButton.swift
//  Navigation
//
//  Created by Ульви Пашаев on 28.01.2023.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    var buttonAction: () -> Void = { } // closure, в которое будем передавать действие
    
    @objc private func buttonTapped() {
        buttonAction()
    }
    
    // создаем собственный init и передаем в него ряд свойств
    init(title: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat = 7,
         masksToBounds: Bool = true) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
        self.translatesAutoresizingMaskIntoConstraints = false
        //target на кнопку
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
