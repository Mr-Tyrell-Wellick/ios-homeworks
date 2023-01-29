//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 25.10.2022.
//

import Foundation
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    
    // создание экземпляра класса ImagePublisherFacade
    var imagePublisher = ImagePublisherFacade()
    
    //MARK: - Properties
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addViews()
        addConstraints()
        
        // добавление подписчика
        imagePublisher.subscribe(self)
        
        // запуск сценария наполнения коллекции изображениями, используя метод addImagesWithTimer
        imagePublisher.addImagesWithTimer(time: 0.5, repeat: 15)
    }
    
    // отмена отписки, а также обнуление библиотеки с изображениями
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        imagePublisher.removeSubscription(for: self)
        print("cancelled subscription")
        imagePublisher.rechargeImageLibrary()
        print("image library was recharged")
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Photo Gallery"
        
    }
    
    //MARK: - Constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
        return photoInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
//        cell.setup(with: "\(arrayOfImage[indexPath.row])")
        cell.setupImagePublisher(image: photoCollection[indexPath.row])
        return cell
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemSizeInCollection, height: itemSizeInCollection)
    }
}

// реализация метода ImageLibrarySubscriber
extension PhotosViewController {
    func receive(images: [UIImage]) {
        
        photoCollection = images
        photoInSection = images.count
        collectionView.reloadData()
    }
}
