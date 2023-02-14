//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Ульви Пашаев on 09.02.2023.
//

import Foundation
import UIKit
/// Основной координатор приложения, с него начинается показ ПЕРВОГО экрана.
/// Вся ответственность rootCoordinator - выбор экрана для состояния "залогинен" (LoggedIn) или для состояния "надо залогиниться" (LoggedOut).
class RootCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    var childs: [CoordinatorProtocol] = []
    
    private var rootVC: UITabBarController?
    
    // MARK: - Methods
    /// Функция, которая собирает Root координатор. (Грубо говоря собираем то, что мы хотим увидеть на экране)
    func build() -> UIViewController {
        logACtivate()
        let tabBar = UITabBarController() // root в нашем случае - tabBarController
        rootVC = tabBar
        let feedVC = buildFeed() // собираем еще один контроллер внутрь tabBar. (почему так, читаем ниже👇)
        let loginVC = buildLogin()
        tabBar.viewControllers = [feedVC, loginVC] // добавление feedVC and loginVC в tabBar
        tabBar.selectedViewController = feedVC // настройка tabBar
        return tabBar
    }
    
    ///Сборка дочернего экрана для tabBar.
    ///Мы хотим, чтобы первым отобразился FeedViewController, но так как мы хотим, чтобы он был в составе tabBar, добавляем его к tabBar'у.
    private func buildFeed() -> UIViewController {
        ///Логика(аксиома) использования **паттерна**:
        ///когда мы хотим показать с нашего координатора какой-либо дочерний экран,
        ///мы должны не просто создать ViewController, а создать **модуль** координатор +viewController(дочерние)
        let feedCoordinator = FeedCoordinator() // Создаем дочерний координатор
        attachChild(feedCoordinator) //добавляем новый координатор в массив точек, чтобы он не пропал из памяти
        let feedVC = feedCoordinator.build() // получаем из дочернего координатора CC
        ///  возвращаем VC, который имеет при себе координатор.
        ///  Если сделать просто return FeedViewController(), то этот VC не будет иметь при себе координатора.
        ///  Почему так нельзя делать? см. **логику использования паттерна** выше👆
        return feedVC
    }
    
    private func buildLogin() -> UIViewController {
        let coordinator = LoginCoordinator()
        attachChild(coordinator)
        let loginVC = coordinator.build()
        return loginVC
    }
}
