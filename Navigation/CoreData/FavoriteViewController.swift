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
    
    private var data: [Post] = []
    
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
        self.title = "Favorite"
        
        // Создание кнопки удаления/(корзины) в UINAvigationBar
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePosts))
        navigationItem.rightBarButtonItems = [trash]
    }
    
    // MARK: - Actions
    // процесс удаления поста
    @objc func deletePosts() {
        _ = CoreDataManager.defaultManager.delete()
        fetchFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromDB()
    }
    
    // Вызываем метод fetchPosts() из CoreDataManager для извлечения данных из базы данных.
    // Результат извлечения данных сохраняем в fetchedData, которая является массивом объектов типа Favorites.
    // Затем происходит маппинг данных из массива fetchedData в массив объектов типа Post, путем преобразования свойств каждого объекта Favorites в соответствующие свойства объектов Post.
    // Преобразованные объекты Post сохраняем в массив data.
    private func fetchFromDB() {
        let fetchedData = CoreDataManager.defaultManager.fetchPosts()
        data = fetchedData.map { favorite in
            Post(
                author: favorite.author ?? "",
                description: favorite.descText ?? "",
                image: favorite.image ?? "",
                likes: Int(favorite.likes),
                views: Int(favorite.views),
                id: Int(favorite.identificator)
            )
        }
        tableView.reloadData()
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
