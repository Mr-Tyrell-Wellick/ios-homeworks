//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Ульви Пашаев on 08.02.2023.
//

/// Протокол для каждого координатора. Каждый координатор должен быть подписан на него.
protocol CoordinatorProtocol: AnyObject {
    
    /// Массив "детей" координатора. Ребенок в данном случае - любой координатор, который был показан текущим координатором
    /// каждый координатор имеет своих "детей", RootCoordinator выступает папой только для FeedCoordinator'a,
    /// а FeedCoordinator - папа для PostCoordinator'a. RootCoordinator для PostCoordinator'a никто.
    var childs: [CoordinatorProtocol] { get set }
}

extension CoordinatorProtocol {
    func logACtivate() {
        print("Activated: \(type(of: self))")
    }
    /// функция для упрощения добавления "детей" координатора в список "детей"
    func attachChild(_ coordinator: CoordinatorProtocol) {
        childs.append(coordinator)
    }
    /// функция для упрощения удаления "детей" из списка "детей" текущего координатора
    /// удаление осуществляется для предотвращения утечки памяти
    /// если не удалить "ребенка" из списках всех "детей", то останется сильная ссылка внутри массива,
    /// в связи с чем дочерний координатор ("ребенок") останется в памяти
    func detachChild(_ coordinator: CoordinatorProtocol) {
        childs.removeElementByReference(coordinator)
    }
}
