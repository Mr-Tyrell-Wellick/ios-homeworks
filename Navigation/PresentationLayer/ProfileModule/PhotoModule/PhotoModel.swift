//
//  PhotoModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 25.10.2022.
//

import Foundation
import UIKit

// свойства для реализации заполнения коллекции через pattern Facade 
var photoInSection: Int = 0
var photoCollection: [UIImage] = []


// Размер ячеек
let itemSizeInCollection = (UIScreen.main.bounds.width - 32)/3

// Массив с названием картинок
let arrayOfImage: [String] = ["photo1.jpeg", "photo2.jpeg", "photo3.jpeg", "photo4.jpeg", "photo5.jpeg", "photo6.jpeg", "photo7.jpeg", "photo8.jpeg", "photo9.jpeg", "photo10.jpeg", "photo11.jpeg", "photo12.jpeg", "photo13.jpeg", "photo14.jpeg", "photo15.jpeg", "photo16.jpeg", "photo17.jpeg", "photo18.jpeg", "photo19.jpeg", "photo20.jpeg"]

// небольшой массив для задания с многопоточностью
var threadArrayOfImage: [UIImage] = [UIImage(named: "photo1.jpeg")!, UIImage(named: "photo2.jpeg")!, UIImage(named: "photo3.jpeg")!, UIImage(named: "photo4.jpeg")!, UIImage(named: "photo5.jpeg")!, UIImage(named: "photo6.jpeg")!]
