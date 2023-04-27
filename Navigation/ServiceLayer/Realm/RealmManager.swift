//
//  RealmManager.swift
//  Navigation
//
//  Created by Ульви Пашаев on 04.04.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    
    var realm: Realm!
    var realmUsers: [RealmUsers] = []
    
    init() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        guard let realm = try? Realm() else { fatalError() }
        self.realm = realm
    }
    
    // перезагружаем список пользователей из базы данных Realm и сохраняем в свойстве realmUsers
    func reloadUserData() {
        realmUsers = Array(realm.objects(RealmUsers.self))
    }
    
    // сохраняем нового пользователя в базу данных Realm c указанным логином и паролем
    func saveRealmUser(login: String, password: String) {
        do {
            try realm.write {
                let users = RealmUsers(login: login, password: password)
                realm.add(users)
            }
        } catch let error {
            print("error saving user: \(error.localizedDescription)")
        }
    }
}
