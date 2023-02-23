//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Ульви Пашаев on 25.10.2022.
//

import Foundation
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    // создание картинки
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // функция отображения изображения (по имени)
    
    func setup(with name: String) {
        self.image.image = UIImage(named: name)
    }
    
    // функция отображения изображения (по картинке)
    func setupImagePublisher(image: UIImage) {
        self.image.image = image
    }
    
    func setupWithIndex(with index: Int) {
        self.image.image = threadArrayOfImage[index]
    }
    
    
    //MARK: - Constraints
    
    private func setupView() {
        self.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
