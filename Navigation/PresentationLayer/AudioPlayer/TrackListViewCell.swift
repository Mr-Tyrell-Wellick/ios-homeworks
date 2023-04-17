//
//  TrackListViewCell.swift
//  Navigation
//
//  Created by Ульви Пашаев on 07.03.2023.
//

import Foundation
import UIKit

class TrackListViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    // Название трека
    var trackNameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        titleLabel.textColor = #colorLiteral(red: 0.9463383838, green: 0.9463383838, blue: 0.9463383838, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // имя исполнителя (название группы)
    var trackAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = #colorLiteral(red: 1, green: 0, blue: 0.434411068, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // обложка трека
    var trackImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addViews() {
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(trackAuthorLabel)
        contentView.addSubview(trackImage)
    }
    
    // MARK: - Constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            trackNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 120),
            
            trackAuthorLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 6),
            trackAuthorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 120),
            
            trackImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            trackImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            trackImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            trackImage.widthAnchor.constraint(equalToConstant: 100),
            trackImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
