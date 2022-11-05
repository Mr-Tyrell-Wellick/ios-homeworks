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
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableCellID")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // полупрозначная view, перекрывающая остальные элементы на экране.
    private lazy var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // копия аватарки для тапа и анимации
    private lazy var hiddenAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Lalo")
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.isHidden = true
        return image
    }()
    
    // Х для закрытия окна, реализованная через Image
    
    private lazy var hiddenCloseView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark.square.fill")
        image.tintColor = .white
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)
        
        addViews()
        addConstraints()
        addGestures()
        addNotification()
        
    }
    
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(hiddenView)
        view.addSubview(hiddenAvatar)
        view.addSubview(hiddenCloseView)
    }
    
    // метод тапа аватарки
    func addGestures() {
        //tap'aeм аву
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_ :)))
        self.hiddenAvatar.addGestureRecognizer(tapGestureRecognizer)
        
        
        // закрываем аву (Х)
        let tapGestureRecognizerTwo = UITapGestureRecognizer(target: self, action: #selector(self.tapClose(_ :)))
        self.hiddenCloseView.addGestureRecognizer(tapGestureRecognizerTwo)
    }
    
    @objc func AvatarTap(notification: Notification) {
        showAnimation()
        
    }
    
    // функция, срабатывающая при нажатии на аватарку
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        showAnimation()
        
    }
    
    // функция, срабатывающая при тапе на Х (для закрытия аватарки)
    @objc func tapClose(_ gestureRecognizer: UITapGestureRecognizer) {
        closeAnimation()
    }
    
    // функция показа анимации
    private func showAnimation() {
        
        //вычисление ширины коэффициента, на который будет scale аватарки
        let scaleRatio = self.hiddenView.frame.width / self.hiddenAvatar.frame.width
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            // отображение аватарки и вью
            self.hiddenView.isHidden = false
            self.hiddenAvatar.isHidden = false
            
            // располагаем аватар по центру и увеличиваем
            self.hiddenAvatar.center = self.hiddenView.center
            self.hiddenAvatar.transform = CGAffineTransform(scaleX: scaleRatio, y: scaleRatio)
            self.hiddenAvatar.isUserInteractionEnabled = false
            
            //задний фон делаем полупрозрачным
            self.hiddenView.alpha = 0.5
            self.tableView.applyBlurEffect()
            
        } completion: { _ in
            //по окончанию основной анимации показываем кнопку закрыть
            UIView.animate(withDuration: 0.3, animations: {
                self.hiddenCloseView.isHidden = false
            })
        }
    }
    
    private func closeAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            // реальный размер аватара
            self.hiddenAvatar.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.hiddenAvatar.center = CGPoint(x: 65, y: 112)
            self.hiddenView.alpha = 0 //скрываем задний фон
            self.hiddenCloseView.isHidden = true //прячем кнопку закрыть
            self.hiddenAvatar.isUserInteractionEnabled = true // прячем возможность тапать на скрытую аватарку пока она увеличена
            self.tableView.removeBlurEffect()
            
            // отправляем уведомление о закрытии
        } completion: { _ in
            NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)
            self.hiddenAvatar.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AvatarTap(notification:)),
                                               name: Notification.Name("Avatar Tap"),
                                               object: nil)
    }
    
    // MARK: - constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hiddenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hiddenView.leftAnchor.constraint(equalTo: view.leftAnchor),
            hiddenView.rightAnchor.constraint(equalTo: view.rightAnchor),
            hiddenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hiddenAvatar.topAnchor.constraint(equalTo: hiddenView.topAnchor, constant: 16),
            hiddenAvatar.leftAnchor.constraint(equalTo: hiddenView.leftAnchor, constant: 16),
            hiddenAvatar.widthAnchor.constraint(equalToConstant: 100),
            hiddenAvatar.heightAnchor.constraint(equalToConstant: 100),
            
            hiddenCloseView.topAnchor.constraint(equalTo: hiddenView.topAnchor, constant: 16),
            hiddenCloseView.rightAnchor.constraint(equalTo: hiddenView.rightAnchor, constant: -16),
            hiddenCloseView.widthAnchor.constraint(equalToConstant: 30),
            hiddenCloseView.heightAnchor.constraint(equalToConstant: 30),
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
    
    // ручная настройка высоты ячеек
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        }
        return UITableView.automaticDimension
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

