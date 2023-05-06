//
//  MapViewController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 28.04.2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import TinyConstraints

class MapViewController: UIViewController {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    // MARK: - MapView
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        //отображаем местоположение пользователя
        mapView.showsUserLocation = true
        //отображаем масштабную линейку
        mapView.showsScale = true
        // отображаем компас
        mapView.showsCompass = true
        mapView.delegate = self
        
        
        // Баку
        let initialLocation = CLLocationCoordinate2D(
            latitude: 40.3577,
            longitude: 49.850
        )
        let region = MKCoordinateRegion(
            center: initialLocation,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000)
        mapView.setRegion(region, animated: true)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    // MARK: - Buttons
    // кнопка "текущее местоположение"
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        //иконка кнопки
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.backgroundColor = .white
        button.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        // target на кнопку
        button.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        return button
        
    }()
    // кнопка построения маршрута
    private lazy var routeButton: UIButton = {
        let button = UIButton()
        // иконка кнопки
        button.setImage(UIImage(systemName: "location.north.circle"), for: .normal)
        button.backgroundColor = .white
        button.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // кнопка удаления pin'a
    private lazy var deletePinsButton: UIButton = {
        let button = UIButton()
        //иконка кнопки
        button.setImage(UIImage(systemName: "pin.slash"), for: .normal)
        button.backgroundColor = .white
        button.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        // target на кнопку
        button.addTarget(self, action: #selector(deletePin), for: .touchUpInside)
        return button
    }()
    
    // кнопка переключения типа карт
    private lazy var mapTypeButton: UIButton = {
        let button = UIButton()
        //иконка кнопки
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.backgroundColor = .white
        button.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        // target на кнопку
        button.addTarget(self, action: #selector(didTapMapTypeButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // разрешение на отслеживание местоположения пользователя
        locationManager.requestWhenInUseAuthorization()
        
        addViews()
        pressToAddAnnotation()
        addConstraints()
    }
    
    func addViews() {
        view.addSubview(mapView)
        mapView.addSubview(currentLocationButton)
        mapView.addSubview(deletePinsButton)
        mapView.addSubview(mapTypeButton)
    }
    
    // при удерживании на экран добавляем pin
    func pressToAddAnnotation() {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        longPress.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPress)
    }
    
    // MARK: - Actions
    // функция получения местоположения
    @objc private func getLocation() {
        locationManager.requestLocation()
    }
    
    // функция изменения типа карты (при изменении
    @objc func didTapMapTypeButton() {
        switch mapView.mapType {
        case .hybrid:
            mapView.mapType = .standard
            mapTypeButton.setImage(UIImage(systemName: "map"), for: .normal)
            mapTypeButton.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            mapTypeButton.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            currentLocationButton.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            currentLocationButton.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            deletePinsButton.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            deletePinsButton.tintColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case _:
            mapView.mapType = .hybrid
            mapTypeButton.setImage(UIImage(systemName: "globe"), for: .normal)
            mapTypeButton.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            mapTypeButton.tintColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            currentLocationButton.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            currentLocationButton.tintColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            deletePinsButton.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            deletePinsButton.tintColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    // функция удаления pin'a с карты
    @objc private func deletePin() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    // функция долгого тапа на экран для добавления pin'a
    @objc private func longPressAction(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        mapView.addAnnotation(annotation)
        
        // строим маршрут
        showRouteOnMap(startCoordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(
            latitude: 55.755222, longitude: 37.61556), endCoordinate: newCoordinates)
    }
    
    // метод расчета маршрута и центрирования карты на него
    func showRouteOnMap(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let responses = response else { return }
            
            // выбор маршрута
            if let route = responses.routes.first {
                // отобразить на карте
                mapView.addOverlay(route.polyline)
                // центрируем карту на маршруте
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: MKMapViewDelegate {
    // кастомизация линии маршрута
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
    
    // MARK: - Constraints
    func addConstraints() {
        mapView.edgesToSuperview()
        
        // кнопка переключения типа карт
        mapTypeButton.topToSuperview(offset: 150)
        mapTypeButton.right(to: view, offset: -10)
        mapTypeButton.width(40)
        mapTypeButton.height(40)
        
        // кнопка "текущее местоположение"
        currentLocationButton.bottomToSuperview(offset: -135)
        currentLocationButton.right(to: view, offset: -10)
        currentLocationButton.width(40)
        currentLocationButton.height(40)
        
        // кнопка удаления pin'a
        deletePinsButton.bottomToTop(of: currentLocationButton, offset: -1)
        deletePinsButton.right(to: view, offset: -10)
        deletePinsButton.width(40)
        deletePinsButton.height(40)
    }
}
