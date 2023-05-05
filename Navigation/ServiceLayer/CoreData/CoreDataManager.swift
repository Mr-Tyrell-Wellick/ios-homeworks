//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Ульви Пашаев on 08.04.2023.
//

import Foundation
import CoreData


final class CoreDataManager {
    
    //singleton
    static let defaultManager = CoreDataManager()
    
    private init() {
    }
    
   private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // сохранение background контекста
    private func saveBackgroundContext() {
        let context = backgroundContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // добавление поста в background контекст
    func addPostToFavorite(author: String,
                           descText: String,
                           image: String,
                           likes: Int64,
                           views: Int64,
                           identificator: Int64
    ) {
        backgroundContext.perform { [self] in
            // создаем экземпляр NSManagedObject
            let favoritePost = Favorites(context: backgroundContext)
            
            favoritePost.author = author
            favoritePost.descText = descText
            favoritePost.image = image
            favoritePost.likes = likes
            favoritePost.views = views
            favoritePost.identificator = identificator
            saveBackgroundContext()
        }
    }
    
    func fetchPosts() -> [Favorites] {
        let fetchRequest = Favorites.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        do {
            let postFetched = try persistentContainer.viewContext.fetch(fetchRequest)
            return postFetched
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // удаление всех добавленных постов (через кнопку корзина)
    func deleteAll() -> Bool {
        let response = Favorites.fetchRequest()
        do {
            let context = persistentContainer.viewContext
            let posts = try context.fetch(response)
            for post in posts {
                context.delete(post)
            }
            saveContext()
            return true
        } catch {
            print (error)
            return false
        }
    }
    
    // удаление по (в нашем случае по свайпу)
    func deleteBy(id: Int, _ callback: @escaping () -> ()) {
        backgroundContext.perform { [self] in
            let fetchRequest = Favorites.fetchRequest()
            // с помощью predicate получаем только то, что хотим удалить. %K - свойство у модели БД, %@ - то с чем сравниваем.
            // %K == #keyPath(Favorites.identificator), $@ == id => identificator == id (конечное условие)
            fetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Favorites.identificator), id])
            do {
                let result = try backgroundContext.fetch(fetchRequest)
                result.forEach { backgroundContext.delete($0) }
                saveBackgroundContext()
                callback()
            } catch {
                print(error)
                callback()
            }
        }
    }
    
    // принимаем имя автора в качестве аргумента и использует NSPredicate для создания фильтрации по имени автора. Затем она выполняет fetch запрос в persistentContainer.viewContext с использованием созданного предиката и возвращает найденные посты.
    func searchPostsByAuthorName(authorName: String) -> [Favorites] {
        let fetchRequest = Favorites.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "%K CONTAINS [cd] %@", argumentArray: [#keyPath(Favorites.author), authorName])
        do {
            let posts = try persistentContainer.viewContext.fetch(fetchRequest)
            return posts
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // MARK: - CoreData stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // создание background контекста
    private lazy var backgroundContext: NSManagedObjectContext = {
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSOverwriteMergePolicy
        backgroundContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return backgroundContext
    }()
}
