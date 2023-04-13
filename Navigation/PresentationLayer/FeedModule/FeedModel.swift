//
//  FeedModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 29.01.2023.
//

import Foundation
import UIKit

// создание нового класса, содержащее секретное слово
struct FeedModel {

    let secretWord: String = "word"
    
    //метод, проверяющий ведденое слово на соответствие сохраненному
    func check(word: String) -> Bool {
        secretWord == word ? true : false
    }
}
