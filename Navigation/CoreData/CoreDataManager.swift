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
    
    func saveContext () {
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
    
    
    func addPostToFavorite(author: String, descText: String, image: String, likes: Int64, views: Int64) {
        
        // создаем экземпляр NSManagedObject
        let favoritePost = Favorites(context: persistentContainer.viewContext)
        
        favoritePost.author = author
        favoritePost.descText = descText
        favoritePost.image = image
        favoritePost.likes = likes
        favoritePost.views = views
        
        saveContext()
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
    
    func delete() -> Bool {
        let response = Favorites.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(response)
            let context = persistentContainer.viewContext
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
}
