//
//  String+extension.swift
//  Navigation
//
//  Created by Ульви Пашаев on 05.05.2023.
//

import Foundation

extension String {
    func localizedString() -> String {
        NSLocalizedString(self, comment: "")
    }
}
