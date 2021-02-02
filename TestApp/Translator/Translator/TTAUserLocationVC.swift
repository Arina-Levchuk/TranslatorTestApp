//
//  TTAUserLocationVC.swift
//  Translator
//
//  Created by admin on 11/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation


protocol TTAUserLocationVCDelegate: class {
    func passUserCoordinates(latitude: Double, longitude: Double)
}


class TTAUserLocationVC: UIViewController {

    let mapView = MKMapView()
        
//    weak var delegate: TTAUserLocationVCDelegate? = nil
    
//    lazy var locationManager: CLLocationManager = {
//        var manager = CLLocationManager()
//        manager.distanceFilter = 10
//        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        return manager
//    }()
    
//    let userLocation: CLLocation? = nil
        
    let latitude: Double?
    let longitude: Double?
    
    var locationTestLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .systemPurple
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    init(latitude: Double?, longitude: Double?) {
//        self.delegate = delegate
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
        setupUserLocation()
        mapView.showsUserLocation = true
        
        setupTestLabel()
        
    }
    
    func setupTestLabel() {
        mapView.addSubview(locationTestLabel)
        
        locationTestLabel.topAnchor.constraint(equalTo: mapView.topAnchor).isActive = true
        locationTestLabel.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        locationTestLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationTestLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        locationTestLabel.text = "LTD: \(self.latitude ?? 0.000); LNGTD: \(self.longitude ?? 0.000)"
    }
    
    func setUpMapView() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
 
    func setupUserLocation() {
//        Setting region
        let coordinate = CLLocationCoordinate2D(latitude: (self.latitude)!, longitude: (self.longitude)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
//        Adding pin
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake((self.latitude)!, (self.longitude)!)
        let objectAnnotation = MKPointAnnotation()
        
        objectAnnotation.coordinate = pinLocation
        self.mapView.addAnnotation(objectAnnotation)
        
    }

}

//extension TTAUserLocationVC: CLLocationManagerDelegate {}
