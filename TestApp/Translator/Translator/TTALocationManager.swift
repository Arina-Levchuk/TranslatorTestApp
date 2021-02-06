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
        
    private override init() {}
    
//    deinit {
//        destroyLocationManager()
//    }
    
//    MARK:- Methods
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.distanceFilter = 1
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager?.startMonitoringVisits()
        locationManager?.requestWhenInUseAuthorization()
    
    }
    
//    func destroyLocationManager() {
//        locationManager?.delegate = nil
//        locationManager = nil
//        currentLocation = nil
//    }

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
            locationManager?.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
            locationManager?.startUpdatingLocation()
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            print("parental control setting disallow location data")
        @unknown default:
            fatalError()
        }

    }
    
    
}
