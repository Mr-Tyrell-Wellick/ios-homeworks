//
//  PostModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 18.10.2022.
//

import Foundation
import UIKit

// размер для ячеек первой секции (которая виднеется в ленте)

let itemSize = (UIScreen.main.bounds.width - 48)/4


struct Post {
    var author: String
    var description: String
    var image: UIImage?
    var likes: Int
    var views: Int
}

var posts: [Post] = [
    Post(author: "vedmak.official", description: "Новые кадры со съемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "image1"), likes: 240, views: 312),
    Post(author: "Нетология. Меняем карьеру через образование", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "image2"), likes: 766, views: 893),
    Post(author: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "image1"), likes: 240, views: 312),
    Post(author: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "image2"), likes: 766, views: 893),
]
