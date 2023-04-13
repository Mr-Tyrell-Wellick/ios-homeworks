//
//  PostModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 18.10.2022.
//


import Foundation
import UIKit

// размер для ячеек первой секции (которая виднеется в ленте)

public let itemSize = (UIScreen.main.bounds.width - 48)/4

public struct Post {
    public init(author: String, description: String, image: String, likes: Int, views: Int, id: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        self.id = id
    }
    
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    public var id: Int
}

// Массив с данными для ленты постов
public var posts: [Post] = [
    Post(
        author: "vedmak.official",
        description: "Новые кадры со съемок второго сезона сериала \"Ведьмак \"",
        image: "image1",
        likes: 240,
        views: 312,
        id: 0),
    Post(
        author: "Нетология. Меняем карьеру через образование",
        description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».",
        image: "image2",
        likes: 766,
        views: 893, id: 1),
    Post(
        author: "vedmak.official",
        description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"",
        image: "image1",
        likes: 240,
        views: 312, id: 2),
    
    Post(
        author: "Нетология. Меняем карьеру через образование.",
        description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».",
        image: "image2",
        likes: 766,
        views: 893,
        id: 3),
]
