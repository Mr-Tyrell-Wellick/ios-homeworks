//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 13.09.2022.
//

import Foundation
import UIKit
import TinyConstraints

class InfoViewController: UIViewController, UITableViewDelegate {
    
    // создание всплывающего окна(alert) (отображение предупреждающего сообщения)
    let alertController = UIAlertController(title: "Error", message: "Please buy full version of App", preferredStyle: .alert)
    
    let jsonAlertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
    
    //создаем кнопку для закрытия модального окна
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor .white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //    // создаем кнопку для показа Alert'a
    //    private let buttonAlert: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Alert", for: .normal)
    //        button.backgroundColor = .black
    //        button.layer.cornerRadius = 7
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        return button
    //    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = dataTitle
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var orbitaLabel: UILabel = {
        let label = UILabel()
        label.text = "planet’s orbital period:\n \(orbitalPeriod) days"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    создаем tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        //view.addSubview(buttonAlert)
        setupAlertConfiguration()
        addViews()
        addConstraints()
        
        
        // target на закрытие окна
        closeButton.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
        
        //        // target на открытие showAlert'a
        //        buttonAlert.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    func addViews() {
        view.addSubview(closeButton)
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(orbitaLabel)
    }
    //метод закрытия модального окна
    @objc func showPostController() {
        self.dismiss(animated: true, completion: nil)
    }
    //метод показа алерта (всплывающего окна)
    @objc func showAlert() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    // метод показа предупреждающего окна
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("only today you can buy it for 10$")
        }))
        //        alertController.addAction(UIAlertAction(title: "NO Thanks", style: .default, handler: { _ in
        //            print("Make money and come back")
        //        }))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Constraints
    func addConstraints() {
        
        closeButton.top(to: view, offset: 50)
        closeButton.centerX(to: view)
        
        titleLabel.centerX(to: view)
        titleLabel.topToBottom(of: closeButton, offset: 50)
        
        orbitaLabel.centerX(to: view)
        orbitaLabel.topToBottom(of: titleLabel, offset: 10)
        
        tableView.topToBottom(of: orbitaLabel, offset: 30)
        tableView.bottom(to: view)
        tableView.left(to: view)
        tableView.right(to: view)
    }
}

// MARK: - Extensions

extension InfoViewController: UITableViewDataSource {
    // количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count //количество равносительное количеству резидентов
    }
    // заполнение таблицы данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellID", for: indexPath)
        
        InfoNetworkService.request(for: residents[indexPath.row], index: indexPath.row)
        cell.textLabel?.text = residentsName[indexPath.row]
        return cell
    }
}
