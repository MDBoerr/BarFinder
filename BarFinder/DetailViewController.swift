//
//  DetailViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import Firebase
import MapKit


class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let barStore : BarStore! = BarStore()
    var locationManager = CLLocationManager()
    var longlat: CLLocationCoordinate2D!
    var region: MKCoordinateRegion!
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailMapView: MKMapView!
    @IBOutlet var ratingLabel: UILabel!
    var detailBar : Bar?
    
    
    var bar : Bar! {
        didSet {
            navigationItem.title = bar.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = bar?.address
        navigationController?.isNavigationBarHidden = false
        imageView.image = bar.image
        ratingLabel.text = "Rating: \(bar!.rating)/10"
        
    }
    func detailMap() {
        // detailMapView.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.longlat = manager.location!.coordinate
        
        self.region = MKCoordinateRegion(center: self.longlat, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    }
    let color : UIColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
//        detailMapView = MKMapView()
        locationManager.delegate = self
        detailMapView.delegate = self
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        detailMapView.showsUserLocation = true
        
        dropPinForSelectedBar()

    }
    func dropPinForSelectedBar() {
        
            let locationBar = CLLocationCoordinate2D(latitude: bar.latitude, longitude: bar.longitude)
        
            let span = MKCoordinateSpanMake(0.05, 0.05)
            
            let regionBar = MKCoordinateRegion(center: locationBar, span: span)
            detailMapView.setRegion(regionBar, animated: true)
        
            let annotationBar = MKPointAnnotation()
            annotationBar.coordinate = locationBar
            annotationBar.title = bar.name
            annotationBar.subtitle = bar.address
            detailMapView.addAnnotation(annotationBar)
        }
    }

//

