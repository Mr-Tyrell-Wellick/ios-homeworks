//
//  ViewModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 12.02.2023.
//

import Foundation

class FeedViewModel {
    
    let feedModel = FeedModel()
    
    var statusText = Observable("")
    // метод проверки
    func checkPass(word: String) -> Bool {
        if word == feedModel.secretWord {
            statusText.value = "True"
            return true
        } else {
            statusText.value = "False"
            return false
        }
    }
}
