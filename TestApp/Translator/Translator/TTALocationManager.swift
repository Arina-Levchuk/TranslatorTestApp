//
//  TTALocationManager.swift
//  Translator
//
//  Created by admin on 1/28/21.
//  Copyright © 2021 admin. All rights reserved.
//


import CoreLocation

final class TTALocationManager: NSObject {
    
//    private let locationManager = CLLocationManager()
    
    var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()
    
    override init() {
        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getUserLocation()
    }
      
//    MARK:- Methods
    
    func retrieveLocation() {

        let status = CLLocationManager.authorizationStatus()

        if status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled() {
            return
        } else if status == .notDetermined {

        // if haven't show location permission dialog before, show it to user
            locationManager.requestWhenInUseAuthorization()
            return
            
        }
        // request location data once
        locationManager.requestLocation()

        // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
//        locationManager.startUpdatingLocation()
    }
    
    func getUserLocation() {
        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestLocation()
        } else {
            retrieveLocation()
        }
    }
    
}

//   MARK:- Extensions

extension TTALocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("localizationManager error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            print("Current location is: \(location)")
        }
    
//        render(latitude: self.latitude, longitude: self.longitude!)
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
        @unknown default:
            fatalError()
        }

    }
    
    
}
