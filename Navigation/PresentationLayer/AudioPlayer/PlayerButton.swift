//
//  PlayerButton.swift
//  Navigation
//
//  Created by Ульви Пашаев on 07.03.2023.
//

import Foundation
import UIKit

final class PlayerButton: UIButton {
    
    var buttonAction: () -> Void = { } // closure, в которое будем передавать действие
    
    @objc private func buttonTapped() {
        buttonAction()
    }
    
    // создаем собственный init и передаем в него ряд свойств
    init(image: String) {
        super.init(frame: .zero)
        
        let image = UIImage(systemName: image)
        self.setImage(image, for: .normal)
        self.tintColor = .white
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        // target на кнопку
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
