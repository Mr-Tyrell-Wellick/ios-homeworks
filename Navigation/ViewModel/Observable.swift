//
//  Observable.swift
//  Navigation
//
//  Created by Ульви Пашаев on 12.02.2023.
//

import Foundation
import UIKit

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
