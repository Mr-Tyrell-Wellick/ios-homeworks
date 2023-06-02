//
//  RealmModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 04.04.2023.
//

import Foundation
import UIKit
import RealmSwift

class RealmUsers:Object {
    
    @Persisted (primaryKey: true) var primaryKey: ObjectId
    
    @Persisted var login: String
    @Persisted var password: String
    
    convenience init(login:String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}
