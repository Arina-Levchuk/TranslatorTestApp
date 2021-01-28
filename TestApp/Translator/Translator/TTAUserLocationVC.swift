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

//        getUserLocation()
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
    
    func render(latitude ltd: Double?, longitude lgd: Double) {
        
        let coordinate = CLLocationCoordinate2D(latitude: ltd!, longitude: lgd)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }

}

extension TTAUserLocationVC: CLLocationManagerDelegate {
    
//  ????
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            self.delegate?.passUserCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        
        render(latitude: self.latitude, longitude: self.longitude!)
    }
    
}
