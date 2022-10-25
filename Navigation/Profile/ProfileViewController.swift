//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 19.10.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableCellID")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)
        
        view.addSubview(tableView)
        
        addConstraints()
    }
    
    // MARK: - constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        }
        return nil
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    // количество секций (изменили на 2 после того, как появилась лента с фото)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // настройка количества строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return posts.count
        }
        return 0
    }
    
    // tap секции с фото. Переход в PhotosViewController
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: false)
        }
        
    }
    
    //  метод переиспользуемой ячейки, и ее заполнение данными.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { //нулевая секция с лентой фотографий
            return PhotosTableViewCell()
        } else if indexPath.section == 1 { //первая секция лента с новостями(постами)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableCellID", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellID", for: indexPath)
                return cell
            }
            
            let post = posts[indexPath.row]
            let postViewModel = PostTableViewCell.ViewModel(
                author: post.author,
                descriptionText: post.description,
                image: post.image,
                likes: "Likes:\(post.likes)",
                views: "Views: \(post.views)"
            )
            cell.setup(with: postViewModel)
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "defaultTableCellID", for: indexPath)
        }
    }
}
