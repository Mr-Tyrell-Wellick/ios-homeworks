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
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    
        return label
    }()
    
    
    // создаем экземпляр класса ProfileHeaderView
    let profileView: UIView = {
        let view = ProfileHeaderView()
        return view
    }()
    
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(titleLable)
        view.addSubview(profileView)
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileView.frame = view.frame
    }
}
