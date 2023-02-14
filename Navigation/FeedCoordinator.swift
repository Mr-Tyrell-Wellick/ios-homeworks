//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Ульви Пашаев on 09.02.2023.
//

import Foundation
import UIKit

/// FeedCoordinator помогает FeedViewController'у в показе новых экранов (своего рода менеджер показа экранов относительно FeedViewController)
class FeedCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    var childs: [CoordinatorProtocol] = []
    
    /// "главный" или родительский экран для координатора.
    /// Это не тот, который его показал, а тот который будет его показывать, то есть:
    /// RootCoorinator.rootVC = RootViewController
    /// LoggedInCoordinator.rootVC = LoggedViewController
    /// это тот экран, который **делегировал** управление показом других экранов нашему координатору
    private var rootVC: UIViewController?
    
    /// Переменная которая держит слабую ссылку на дочерний координатор нашего FeedCoordinator.
    /// Она нам понадобится, когда мы захотим проверить - показан ли Post экран или нет.
    ///
    /// Захотим мы это проверить, когда нам надо будет удалить экран из памяти(когда он закроется)
    /// Если у нас не будет этой переменной, то мы сможем найти конкретный дочерний экран в массиве childs
    /// Почему не сможем? - там лежат объекты CoordinatorProtocol (поддерживающие протокол), а не FeedCoordinator или PostCoordinator (конкретные классы) и т.д.
    /// Общение у нас осуществляется с ними **только** по протоколу
    /// В общем, для нас на первый взгляд они будут одинаковые - все CoordinatorProtocol
    /// И вот чтобы найти нужный(конкретный) координатор, мы держим ссылку на post, а затем при просмотре массива childs,
    /// проверяем по адресу памяти каждый экран - когда найдем соответвующий адрес - удалим его из массива
    ///
    /// слабая ссылка нужна для того, чтобы мы могли легко удалить дочерний координатор из массива childs.
    
    private weak var post: PostCoordinator?
    
    // MARK: - Methods
    /// также как и в RootCoordinator - собираем то, что хотим увидеть (тот экран, которому помогает наш координатор)
    func build() -> UIViewController {
        logACtivate()
        let feedVC = FeedViewController() // создаем экземпляр экрана
        feedVC.coordinator = self // говорим экрану, что ему помогает наш координатор
        rootVC = feedVC // так как главный экран координатора FeedVC - делаем его rootVC. (см. описание rootVC👆)
        
        /// так как мы хотим, чтобы наш FeedVC был завернут внутрь NavigationVC - делаем экземпляр NavigationVC - делаем экземпляр NavigationVC
        /// и в качестве rootViewController указываем наш FeedVC
        /// то есть обычное использование UINavigationController
        let navigationController = UINavigationController.init(rootViewController: feedVC)
        return navigationController
    }
    
    
    /// Эта функция нужна нашему FeedVC, которому мы помогаем показывать экраны.
    /// Когда FeedVC захочет показать экран (например при нажатии на кнопку) - он обратится к нам и попросит показать для него PostScreen
    /// Тут то эта функция и сделает всю грязную работа за FeedVC - создат новый экран, создат новый координатор к нему и т.д.
    func showPostScreen(title: String) {
        let coordinator = PostCoordinator() // создаем экземпляр PostCoordinator(см. аксиому паттерна в RootCoordinator'e)
        
        ///говорим новому координатору, что мы являемся его слушателем
        ///Это надо для того, чтобы когда экран Post закроется, PostCoordinator нам об этом сообщил и мы могли очистить память
        ///это пример отношений от дочернего координатора к родительскому:
        ///дочерний -> родительский
        coordinator.listener = self
        
        let postVC = coordinator.build(title: title) // создаем PostViewController
        /// присваеваем переменной post (см. выше) ссылку на нашего нового координатора
        /// говорим, что наш экран Post - показан
        post = coordinator
        attachChild(coordinator) // добавляем новый координатор в массив childs у FeedCoordinator
        rootVC?.navigationController?.pushViewController(postVC, animated: true) // показываем PostVC, используя rootVC (в нашем случае - это FeedVC, см. функцию build)
    }
}

/// extension к FeedCoordinator, который подписывает его под протокол слушателя PostCoordinator
/// PostCoordinatorListener находится в файле PostCoordinator
/// Это протокол для общения **дочка -> родитель**
extension FeedCoordinator: PostCoordinatorListener {
    ///PostCoordinator вызовет эту функцию, когда он закроется и мы об этом **узнаем**
    ///Когда она вызовется - мы удалим его из памяти FeedCoordinator - из массива childs
    func postDidClose() {
        guard let post = post else { return }
        detachChild(post) // удаляем post из массива childs. 
    }
}
