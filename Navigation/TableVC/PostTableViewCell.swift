//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Ульви Пашаев on 18.10.2022.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel {
        
        let author: String
        let descriptionText: String
        let image: UIImage?
        let likes: String
        let views: String
    }
    
    private lazy var author: UILabel = {
        let label = UILabel()
        label.text = "vedmak.official"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //первое фото
    private lazy var image: UIImageView = {
        let image1 = UIImageView()
        image1.image = UIImage(named: "image1")
        image1.backgroundColor = .black
        image1.contentMode = .scaleAspectFit
        image1.translatesAutoresizingMaskIntoConstraints = false
        return image1
        
    }()
    
    private lazy var descriptionText: UILabel = {
        let descriptionText = UILabel()
        descriptionText.text = "Новые кадры со съемок второго сезона сериала \"Ведьмак\""
        descriptionText.font = UIFont.systemFont(ofSize: 14)
        descriptionText.textColor = .systemGray
        descriptionText.numberOfLines = 0
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        return descriptionText
    }()
    
    // лайки
    private lazy var likes: UILabel = {
        let likes = UILabel()
        likes.text = "Likes: 643"
        likes.textColor = .black
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    // просмотры
    private lazy var views: UILabel = {
        let views = UILabel()
        views.text = "Views: 893"
        views.textColor = .black
        views.font = UIFont.systemFont(ofSize: 16)
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    //MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addView()
        addConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // метод, который устанавливает текст в лейбл
    func setup(with viewModel: ViewModel) {
        self.author.text = viewModel.author
        self.image.image = viewModel.image
        self.descriptionText.text = viewModel.descriptionText
        self.likes.text = viewModel.likes
        self.views.text = viewModel.views
        
    }
    
    
    // MARK: - добавление view
    
    func addView() {
        
        self.contentView.addSubview(author)
        self.contentView.addSubview(image)
        self.contentView.addSubview(descriptionText)
        self.contentView.addSubview(likes)
        self.contentView.addSubview(views)
    }
    
    
    // MARK: - Constraints
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            self.author.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.author.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.author.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.image.topAnchor.constraint(equalTo: self.author.bottomAnchor, constant: 12),
            self.image.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            self.image.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            self.image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            self.descriptionText.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 16),
            self.descriptionText.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.descriptionText.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.likes.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor, constant: 16),
            self.likes.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            
            self.views.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor, constant: 16),
            self.views.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.contentView.bottomAnchor.constraint(equalTo: self.views.bottomAnchor, constant: 16)
        ])
    }
}


