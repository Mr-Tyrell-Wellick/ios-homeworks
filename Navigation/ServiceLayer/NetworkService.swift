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
    
    //hw 2
    case titleData = "https://jsonplaceholder.typicode.com/todos/4"
    case planetData = "https://swapi.dev/api/planets/1"
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

struct Planet: Decodable {
    var name: String
    var rotationPeriod: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surfaceWater: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
}

struct JSONModelResident: Decodable {
    let name: String
}
// Определяем переменную dataTitle типа String и инициализируем её пустой строкой
var dataTitle: String = ""
var orbitalPeriod: String = ""
var residents: [String] = []
var residentsName: [String] = []

// создаем сетевой сервис
struct InfoNetworkService {
    // Определяем статический метод titleRequest, который принимает объект типа AppConfiguration в качестве аргумента
    static func titleRequest(for configuration: AppConfiguration) {
        // Если возможно получить URL из конфигурации, создаем задачу для получения данных с помощью URLSession.shared
        if let url = URL(string: configuration.rawValue) {// получение url для запроса
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let serilalizedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        
                        if let dictionary = serilalizedDictionary as? [String: Any] {
                            if let title = dictionary["title"] as? String {
                                dataTitle = title
                                print(title)
                            }
                        }
                    } catch let error {
                        // Если произошла ошибка сериализации, выводим её на консоль
                        print(error)
                    }
                }
            }
            // Запускаем задачу URLSession
            task.resume()
        }
    }
    static func orbitalRequest(for configuration: AppConfiguration) {
        if let url = URL(string: configuration.rawValue) {// получение url для запроса
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // в кложуре обрабатываем полученный ответ от сервера. Если в ответе содержатся данные, то распаковываются и декодируются, используя JSONDecoder.
                if let unrappedData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        //декодированные данные преобразуем в объект дипа Planet
                        let planet = try decoder.decode(Planet.self, from: unrappedData)
                        orbitalPeriod = planet.orbitalPeriod //записываем в соответствующие переменные
                        residents = planet.residents// аналогично
                        // создаем массив размер которого равен количество резидентов на планете заполненный пустыми строками
                        residentsName = [String] (repeating: "", count: residents.count)
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    // запускаем для каждого URL жителя Татуина
    static func request(for configuration: String, index: Int) {
        
        let urlSession = URLSession.shared
        
        if let url = URL(string: configuration) {
            let task = urlSession.dataTask(with: url) { data, response, error in
                
                if let parsedData = data {
                    
                    let string = String(data: parsedData, encoding: .utf8)
                    
                    if let serializationString = string {
                        let serializationData = Data(serializationString.utf8)
                        
                        do {
                            if let json = try JSONSerialization.jsonObject(with: serializationData, options: [] ) as? [String: Any] {
                                if let name = json["name"] as? String {
                                    residentsName[index] = name
                                }
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
