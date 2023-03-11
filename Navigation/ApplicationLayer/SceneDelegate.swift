//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Ульви Пашаев on 07.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var appConfiguration: AppConfiguration?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //         MARK: - 1
        //  инициализируем класс TabBarController
        let tabBarController = UITabBarController()
        
        //         MARK: - 2
        // создаем UINavigationController'ы, отвечающие за ленту, логин, профиль и плеер
        var userInterfaceLayout = UINavigationController()
        var profileInterfaceLayout = UINavigationController()
        var loginTabNavigationController = UINavigationController()
        var playerTabNavigationController = UINavigationController()
        
        //         MARK: - 3
        // создаем навигационные контроллеры и объявляем рутовые (стартовые) экраны
        userInterfaceLayout = UINavigationController.init(rootViewController: FeedViewController())
        profileInterfaceLayout = UINavigationController.init(rootViewController: ProfileViewController())
        playerTabNavigationController = UINavigationController.init(rootViewController: TrackListController())
        
        /*
         /// Внедряем зависимость контроллера LoginViewController от LoginInspector
         let loginVC = LogInViewController()
         loginVC.loginDelegate = LoginInspector()
         loginTabNavigationController = UINavigationController.init(rootViewController: loginVC)
         */
        // Внедряем зависимость контроллера LoginViewController от MyLoginFactory
        let loginVC = LogInViewController()
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
        loginTabNavigationController = UINavigationController.init(rootViewController: loginVC)
        
        
        //         MARK: - 4
        // Заполняем  3 контейнера с контроллерами таббара нашими навигационными контроллерами
        //        tabBarController.viewControllers = [userInterfaceLayout, profileInterfaceLayout]
        tabBarController.viewControllers = [userInterfaceLayout, playerTabNavigationController, loginTabNavigationController]
        
        //         MARK: - 5
        //Создаем кнопки, при нажатии которых, мы будем переходить в нужный контроллер)
        
        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        let item3 = UITabBarItem(title: "Player", image: UIImage(systemName: "play.circle"), tag: 1)
        
        //         MARK: - 6
        // Закрепляем за каждым контроллером TabBar'a item
        
        userInterfaceLayout.tabBarItem = item1
        profileInterfaceLayout.tabBarItem = item2
        loginTabNavigationController.tabBarItem = item2
        playerTabNavigationController.tabBarItem = item3
        
        
        //         MARK: - 7
        // Обращаемся к методу, который позволяет кастомизировать TabBar под себя
        UITabBar.appearance().tintColor = UIColor .systemBlue
        UITabBar.appearance().backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        // MARK: - 8
        // Заполняем окно, назначаем ему рутовый экран и делаем видимым
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        
        
        //MARK: - 9
        // Генерируем рандомно элемент и выполняем запрос в сеть
        appConfiguration = AppConfiguration.allCases.randomElement()
        let url = String(appConfiguration?.rawValue ?? "")
        NetWorkService.performRequest(with: url)
        print("Downloading data from: \(url)")
    }
    
    //MARK: - Others
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
