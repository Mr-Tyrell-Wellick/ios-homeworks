//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 09.04.2023.
//

import Foundation
import UIKit
import TinyConstraints
import StorageService


final class FavoriteViewController: UIViewController, UITableViewDelegate {
    
    private var data: [Post] = []
    private var isInSearchedState = false
    private var lastSearchedRequest: String?
    
    //MARK: - Properties
    
    // создаем tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigation()
        addViews()
        addConstraints()
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Navigation customization
    func setupNavigation() {
        // Заголовок
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Favorite"
        
        // Создание кнопки удаления/(корзины) в UINAvigationBar
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePosts))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPost))
        let cancel = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelSearch))
        
        navigationItem.rightBarButtonItems = [trash, search, cancel]
    }
    
    // MARK: - Actions
    // процесс удаления поста
    @objc func deletePosts() {
        _ = CoreDataManager.defaultManager.deleteAll()
        fetchFromDB()
    }
    
    
    //MARK: - TODO (прописать функцию поиска постов)
    
    // процесс поиска поста по имени автора
    @objc func searchPost() {
        
        let alert = UIAlertController(title: "Search by Author", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Author name"
        }
        // создаем кнопку "Cancel" (отмены)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // для кнопки отмены устанавливаем красный цвет
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Создаем кнопку поиска
        let searchAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let authorName = alert.textFields?.first?.text {
                
                self?.searchByAuthor(authorName)
                self?.isInSearchedState = true
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(searchAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private func searchByAuthor(_ authorName: String) {
        let result = CoreDataManager.defaultManager.searchPostsByAuthorName(authorName: authorName)
        data = convertFromDB(result)
        tableView.reloadData()
        lastSearchedRequest = authorName
    }
    
    @objc func cancelSearch() {
        isInSearchedState = false
        lastSearchedRequest = nil
        fetchFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInSearchedState {
            guard let authorName = lastSearchedRequest else { return }
            searchByAuthor(authorName)
        } else {
            fetchFromDB()
        }
    }
    
    // Вызываем метод fetchPosts() из CoreDataManager для извлечения данных из базы данных.
    // Результат извлечения данных сохраняем в fetchedData, которая является массивом объектов типа Favorites.
    // Затем происходит маппинг данных из массива fetchedData в массив объектов типа Post, путем преобразования свойств каждого объекта Favorites в соответствующие свойства объектов Post.
    // Преобразованные объекты Post сохраняем в массив data.
    private func fetchFromDB() {
        let fetchedData = CoreDataManager.defaultManager.fetchPosts()
        data = convertFromDB(fetchedData)
        tableView.reloadData()
    }
    
    private func convertFromDB(_ data: [Favorites]) -> [Post] {
        data.map { favorite in
            Post(
                author: favorite.author ?? "",
                description: favorite.descText ?? "",
                image: favorite.image ?? "",
                likes: Int(favorite.likes),
                views: Int(favorite.views),
                id: Int(favorite.identificator)
            )
        }
    }
    
    // MARK: - Constraints
    func addConstraints() {
        
        tableView.topToSuperview(usingSafeArea: true)
        tableView.bottomToSuperview()
        tableView.leftToSuperview()
        tableView.rightToSuperview()
    }
}

// MARK: - Extensions
extension FavoriteViewController: UITableViewDataSource {
    
    // количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // количество строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // удаление данных с помошью свайпа
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            createDeleteAction(for: indexPath)
        ])
    }
    
    private func createDeleteAction(for indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "") { action, view, callback in
            self.deletePost(in: indexPath)
            callback(false)
        }
        action.image = UIImage(systemName: "trash")
        return action
    }
    
    private func deletePost(in indexPath: IndexPath) {
        let post = data[indexPath.row]
        CoreDataManager.defaultManager.deleteBy(id: post.id) { [weak self] in
            DispatchQueue.main.async {
                self?.fetchFromDB()
            }
        }
    }
    
    // заполняем данными таблицу
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellID", for: indexPath)
            return cell
        }
        cell.setup(data[indexPath.row])
        return cell
    }
}
