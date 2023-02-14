//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Ульви Пашаев on 07.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    /// переменная нужная, чтобы на root держалась сильная ссылка
    /// (если ее  не будет, то она не будет запускаться и отображаться в памяти)
    private var rootCoordinator: RootCoordinator!
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //         MARK: - 1
        // Создаем coordinator и передаем в него transitionHandler
        rootCoordinator = RootCoordinator()
        let rootVC = rootCoordinator.build()
        
        //         MARK: - 2
        // Обращаемся к методу, который позволяет кастомизировать TabBar под себя
        UITabBar.appearance().tintColor = UIColor .systemBlue
        UITabBar.appearance().backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        //         MARK: - 3
        // Заполняем окно, назначаем ему рутовый экран и делаем видимым
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        self.window = window
    }
}
