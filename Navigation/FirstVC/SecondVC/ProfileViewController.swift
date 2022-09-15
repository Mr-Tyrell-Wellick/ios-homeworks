//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 10.09.2022.
//

import Foundation
import UIKit

class ProfileTabVC: UIViewController {
    
    // MARK: - Properties
    
    private let titleLable: UILabel = {
        let label = UILabel(frame: CGRect(x: 178, y: 40, width: 300, height: 100))
        label.text = "Profile"
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(titleLable)
        
    }
    
}
