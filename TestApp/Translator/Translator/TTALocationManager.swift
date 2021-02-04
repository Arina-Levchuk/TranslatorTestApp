//
//  TTALocationManager.swift
//  Translator
//
//  Created by admin on 1/28/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
import CoreLocation


final class TTALocationManager: NSObject {

//    Singleton instance
    static let shared: TTALocationManager = {
        let locationManager = TTALocationManager()
        return locationManager
    }()
    
    private var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
//        var manager = CLLocationManager()
//        manager.distanceFilter = 10
//        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        return manager
//    }()
    
    private override init() {}
    
    deinit {
        destroyLocationManager()
    }
    
//    MARK:- Methods
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.distanceFilter = 1
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager?.requestWhenInUseAuthorization()
        
        getUserLocation()
    }
    
    func destroyLocationManager() {
        locationManager?.delegate = nil
        locationManager = nil
        currentLocation = nil
    }

    func getUserLocation() {
//        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager?.startUpdatingLocation()
        } else {
            retrieveLocation()
        }
    }
    
    func retrieveLocation() {
        let status = CLLocationManager.authorizationStatus()

        if (status == .denied) || (status == .restricted) || (!CLLocationManager.locationServicesEnabled()) {
//      TODO: to show alert??
            
            
        } else if (status == .notDetermined) {

        // if haven't show location permission dialog before, show it to user
            locationManager?.requestWhenInUseAuthorization()
            return
            
        }
        // request location data once
//        locationManager.requestLocation()

        // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
        locationManager?.startUpdatingLocation()
    }
    
    func showAlert(presenter: UIViewController) {
        let alert = UIAlertController(title: "Allow Location Access", message: "The app needs access to your location. Please turn on Location Services in your device settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        presenter.present(alert, animated: true)
        
    }

    
}

//   MARK:- Extensions

extension TTALocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("localizationManager error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            self.currentLocation = newLocation
            
            locationManager?.stopUpdatingLocation()
            print("Current location is: \(newLocation)")
        
        }

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
