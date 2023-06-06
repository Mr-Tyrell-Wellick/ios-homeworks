//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Ульви Пашаев on 07.09.2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //         MARK: - 1
        //  инициализируем класс TabBarController
        let tabBarController = UITabBarController()
        
        //         MARK: - 2
        // создаем UINavigationController'ы, отвечающие за ленту, логин, профиль и плеер
        var userInterfaceLayout: UINavigationController!
        var profileInterfaceLayout: UINavigationController!
        var loginTabNavigationController: UINavigationController!
        var playerTabNavigationController: UINavigationController!
        var favoriteTabNavigationController: UINavigationController!
        var mapvTabNavigationController: UINavigationController!
        
        //         MARK: - 3
        // создаем навигационные контроллеры и объявляем рутовые (стартовые) экраны
        userInterfaceLayout = .init(rootViewController: FeedViewController())
        profileInterfaceLayout = .init(rootViewController: ProfileViewController())
        playerTabNavigationController = .init(rootViewController: TrackListController())
        favoriteTabNavigationController = .init(rootViewController: FavoriteViewController())
        mapvTabNavigationController = .init(rootViewController: MapViewController())
        
        // Внедряем зависимость контроллера LoginViewController от MyLoginFactory
        let loginVC = LogInViewController()
        loginVC.checkerService = CheckerService()
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
        loginTabNavigationController = .init(rootViewController: loginVC)
        
        
        //         MARK: - 4
        // Заполняем  3 контейнера с контроллерами таббара нашими навигационными контроллерами
        
        tabBarController.viewControllers = [userInterfaceLayout, playerTabNavigationController, favoriteTabNavigationController, loginTabNavigationController, mapvTabNavigationController]
        
        //         MARK: - 5
        //Создаем кнопки, при нажатии которых, мы будем переходить в нужный контроллер)
        
        let item1 = UITabBarItem(title: Strings.tabBarTitle1.localized, image: UIImage(systemName: "newspaper"), tag: 0)
        let item2 = UITabBarItem(title: Strings.tabBarTitle2.localized, image: UIImage(systemName: "person"), tag: 2)
        let item3 = UITabBarItem(title: Strings.tabBarTitle3.localized, image: UIImage(systemName: "play.circle"), tag: 1)
        let item4 = UITabBarItem(title: Strings.tabBarTitle4.localized, image: UIImage(systemName: "heart.rectangle"), tag: 3)
        let item5 = UITabBarItem(title: Strings.tabBarTitle5.localized, image: UIImage(systemName: "map"), tag: 4)
        
        //         MARK: - 6
        // Закрепляем за каждым контроллером TabBar'a item
        
        userInterfaceLayout.tabBarItem = item1
        profileInterfaceLayout.tabBarItem = item2
        loginTabNavigationController.tabBarItem = item2
        playerTabNavigationController.tabBarItem = item3
        favoriteTabNavigationController.tabBarItem = item4
        mapvTabNavigationController.tabBarItem = item5
        
        
        //         MARK: - 7
        // Обращаемся к методу, который позволяет кастомизировать TabBar под себя
        UITabBar.appearance().tintColor = colorTabBarTint
        UITabBar.appearance().backgroundColor = colorTabBarMainBackground
        // MARK: - 8
        // Заполняем окно, назначаем ему рутовый экран и делаем видимым
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        
        
        //MARK: - 9
        // Генерируем рандомно элемент и выполняем запрос в сеть
        appConfiguration = AppConfiguration.allCases.randomElement()
        if !CommandLine.arguments.contains("-tests") {
            let url = String(appConfiguration?.rawValue ?? "")
            NetWorkService.performRequest(with: url)
            print("Downloading data from: \(url)")
        }
        
        //MARK: - 10 (инициализируем кейсы)
        if !CommandLine.arguments.contains("-tests") {
            appConfiguration = AppConfiguration.titleData
            if let url = appConfiguration {
                InfoNetworkService.titleRequest(for: url)
            } else {
                print("Wrong URL to request")
            }
            
            appConfiguration = AppConfiguration.planetData
            if let url = appConfiguration {
                InfoNetworkService.orbitalRequest(for: url)
            } else {
                print("Wrong URL to request")
            }
        }
    }
    
    //MARK: - Others
    func sceneDidDisconnect(_ scene: UIScene) {
        if !CommandLine.arguments.contains("-tests") {
            try? Auth.auth().signOut()
        }
    }
}
