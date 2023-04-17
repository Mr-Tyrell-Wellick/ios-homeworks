//
//  TrackModel.swift
//  Navigation
//
//  Created by Ульви Пашаев on 06.03.2023.
//

import Foundation
import UIKit

struct Track {
    var artistName: String
    var trackName: String
    var image: UIImage
    var fileName: String
}

struct TrackModel {
    
    static var tracks: [Track] = [
        Track(artistName: "Cream Soda", trackName: "Никаких больше вечеринок", image: UIImage(named: "one") ?? UIImage(), fileName: "Cream Soda - Nikakikh bolshe vecherinok"),
        Track(artistName: "Tesla Boy", trackName: "Прогулка", image: UIImage(named: "two") ?? UIImage(), fileName: "Tesla Boy - Progulka"),
        
        Track(artistName: "ScHoolboy Q", trackName: "Hell Of A Night", image: UIImage(named: "three") ?? UIImage(), fileName: "ScHoolboy Q - Hell Of A Night"),
        
        Track(artistName: "Kendrick Lamar", trackName: "Swimming Pools", image: UIImage(named: "four") ?? UIImage(), fileName: "Kendrick Lamar - Swimming Pools"),
        Track(artistName: "Hurts", trackName: "Somebody to Die For", image: UIImage(named: "five") ?? UIImage(), fileName: "Hurts - Somebody to Die For")
    ]
}
