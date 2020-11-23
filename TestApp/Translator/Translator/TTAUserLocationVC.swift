//
//  TTAUserLocationVC.swift
//  Translator
//
//  Created by admin on 11/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


protocol TTAUserLocationVCDelegate: class {
    func passUserCoordinates(latitude: Double, longitude: Double)
}


class TTAUserLocationVC: UIViewController {

    let mapView = MKMapView()
        
    weak var delegate: TTAUserLocationVCDelegate? = nil
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()
        
    let latitude: Double?
    let longitude: Double?
    
    init(delegate: TTAUserLocationVCDelegate?, latitude: Double?, longitude: Double?) {
        self.delegate = delegate
        self.latitude = latitude
        self.longitude = longitude
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getUserLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMapView()
//        getUserLocation()
    }
    
    func setUpMapView() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mapView.showsUserLocation = true
    }
    
    func retrieveLocation() {

        let status = CLLocationManager.authorizationStatus()

        if status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled() {
            return
        }

// if haven't show location permission dialog before, show it to user
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
// request location data once
        locationManager.requestLocation()

// start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
//        locationManager.startUpdatingLocation()
    }
    
    
    func render(latitude ltd: Double?, longitude lgd: Double) {
        
        let coordinate = CLLocationCoordinate2D(latitude: ltd!, longitude: lgd)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }

}

extension TTAUserLocationVC: CLLocationManagerDelegate {
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestLocation()
        }
        
        retrieveLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            self.delegate?.passUserCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        
        render(latitude: self.latitude, longitude: self.longitude!)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        case .restricted:
            print("parental control setting disallow location data")
        }

    }
    
}
