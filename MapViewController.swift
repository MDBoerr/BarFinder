//
//  MapViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView : MKMapView!
    var bar : Bar!
    var barStore = BarStore.sharedInstance
    var locationManager = CLLocationManager()
    var longlat: CLLocationCoordinate2D!
    var region: MKCoordinateRegion!
    var userLocation: CLLocation!
    
    var barArray : [Bar] = []
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        print("Shared instance \(barStore)")
        
        //Segmented control
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        
        
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //Location Button
        let locationButton = UIButton()
        locationButton.setImage(UIImage(named: "locIcon"), for: .normal)
        locationButton.alpha = 1
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationButton)
        
        //Button Constraints right
        let bottomConstaintButton = locationButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8)
        
        let trailingConstraintButton = locationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        bottomConstaintButton.isActive = true
        trailingConstraintButton.isActive = true
        
        locationButton.addTarget(self,  action:#selector(whatIsMyLocation), for: .touchDown)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.longlat = manager.location!.coordinate
        
        self.region = MKCoordinateRegion(center: self.longlat, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    func whatIsMyLocation() {
        if longlat != nil {
            mapView.setCenter(longlat, animated: true)
            mapView.setRegion(region, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        dropPinForBar()
        barArray = barStore.allBars
        print("This is my array: \(barArray)")
        
    }
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .hybrid
        case 2: mapView.mapType = .satellite
        default: break
        }
    }
    func dropPinForBar() {
        
        for bar in barStore.allBars {
            let locationBar = CLLocationCoordinate2D(latitude: bar.latitude, longitude: bar.longitude)
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            
            let regionBar = MKCoordinateRegion(center: locationBar, span: span)
            mapView.setRegion(regionBar, animated: true)
            
            let annotationBar = MKPointAnnotation()
            annotationBar.coordinate = locationBar
            annotationBar.title = bar.name
            annotationBar.subtitle = bar.address
            mapView.addAnnotation(annotationBar)
        }
    }
}
