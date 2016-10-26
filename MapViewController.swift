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
    var locationManager = CLLocationManager()
    var longlat: CLLocationCoordinate2D!
    var region: MKCoordinateRegion!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
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
        
        let locationParents = CLLocationCoordinate2D(latitude: 52.3147612, longitude: 4.682027299999959)
        //let locationBar = m
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let regionParents = MKCoordinateRegion(center: locationParents, span: span)
        mapView.setRegion(regionParents, animated: true)
        
        let annotationParents = MKPointAnnotation()
        annotationParents.coordinate = locationParents
        annotationParents.title = "Cafe Fonteyn"
        mapView.addAnnotation(annotationParents)
        

        
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
        
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .hybrid
        case 2: mapView.mapType = .satellite
        default: break
        }
    }
}
