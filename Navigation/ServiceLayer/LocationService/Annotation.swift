//
//  Annotation.swift
//  Navigation
//
//  Created by Ульви Пашаев on 28.04.2023.
//

import Foundation
import MapKit

final class Annotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        super.init()
    }
}
