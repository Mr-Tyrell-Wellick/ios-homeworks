//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Ульви Пашаев on 12.02.2023.
//

import UIKit
/// Протокол, по которому мы общаемся с родителем нашего PostCoordinator. В нашем случае этот родитель - **FeedCoordinator**
/// AnyObject нужен для применения weak
/// Зачем weak? см. описание **weak var listener** ниже
protocol PostCoordinatorListener: AnyObject {
    /// Функцию, которую мы вызовем, когда наш экран будет закрываться
    func postDidClose()
}

class PostCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    //аналогично предыдущим
    var childs: [CoordinatorProtocol] = []
    
    /// Наш слушатель (делегат), которому мы сообщим о нашем закрытии (это надо, чтобы родитель удалил нас из памяти)
    /// weak нужен, чтобы Feed и post не держали друг на друга сильную ссылку - иначе они оба будут вечно жить в памяти
    weak var listener: PostCoordinatorListener?
    // Аналогично предыдущим
    var rootVC: UIViewController?
    
    // MARK: - Methods
    // Аналогично, что и с прошлыми функциями build(), только эта функция принимает аргумент.
    // Этот аргумент -  наше желание отобразить на postVC конкретный title.
    // Этот title нам передает FeedVC, когда вызывается функцию showPostScreen у своего координатора
    func build(title: String) -> UIViewController {
        logACtivate()
        let postVC = PostViewController()
        postVC.title = title // решили сами показать конкретный title
        postVC.coordinator = self
        rootVC = postVC
        return postVC
    }
    /// Эту функцию вызовет PostVC, когда закроется (в методе viewDidDisappear)
    /// Она сообщит listener'у (слушателю), что нас (PostCoordinator) надо убрать из массива childs родителя, чтобы очистиль от нас память, так как мы закрылись.
    func postDidClose() {
        listener?.postDidClose()
    }
}
