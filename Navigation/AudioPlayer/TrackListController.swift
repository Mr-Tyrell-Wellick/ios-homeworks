//
//  TrackListController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 06.03.2023.
//

import Foundation
import UIKit

final class TrackListController: UIViewController {
    
    // MARK: - Properties
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        return layout
    }()
    
    // создание коллекции
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(TrackListViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // список треков
    let playlist = TrackModel.tracks

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navBarCustomization()
        addViews()
        addConstraints()
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    // настройка верхнего Bar'a
    func navBarCustomization() {
        navigationItem.title = "Playlist"
        
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .yellow
    }
    
    // MARK: - Constraints
    func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TrackListController: UICollectionViewDelegateFlowLayout {
    
    // настройка размеров ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-32, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let position = indexPath.row
        let playerViewController = PlayerController()
        playerViewController.tracklist = playlist
        playerViewController.trackPosition = position
        navigationController?.present(playerViewController, animated: true, completion: nil)
    }
}
    
extension TrackListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! TrackListViewCell
        // Настройте label для каждой ячейки, например:
        let track = playlist[indexPath.row]
        cell.trackNameLabel.text = track.trackName
        cell.trackAuthorLabel.text = track.artistName
        cell.trackImage.image = track.image
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.backgroundColor = .black
        return cell
    }
}
