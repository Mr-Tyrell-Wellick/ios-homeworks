//
//  NetworkService.swift
//  Navigation
//
//  Created by Ульви Пашаев on 11.03.2023.
//

import Foundation

// объявляем enum с 3 case с ассоциированными значениями
enum AppConfiguration: String, CaseIterable {
    
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}
// создаем сетевой сервис
struct NetWorkService {
    
    static func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        //ставим default'ные настройки конфигурации сеанса
        let urlSession = URLSession.shared
        
        // создаем задачу
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let correctData = data, let urlResponse = response as? HTTPURLResponse {
                let dataString = String(data: correctData, encoding: .utf8)
                print("Data: \(dataString ?? "")")
                print("Response Status Code: \(urlResponse.statusCode)")
                print("Response Header Fileds:\(urlResponse.allHeaderFields)")
            }
        }
        task.resume()
    }
}
// при отключенном Wifi :
// Code=-1009 "The Internet connection appears to be offline."
