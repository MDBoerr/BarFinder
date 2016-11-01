//
//  AddBarController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import MapKit

class AddBarController: UIViewController, UINavigationControllerDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, MKMapViewDelegate {
    
    var mapViewCont : MapViewController!
    var locationManager : CLLocationManager = CLLocationManager()
    var longlat : CLLocationCoordinate2D!
    var latitudeUser : CLLocationDegrees!
    var longitudeUser : CLLocationDegrees!
    var coordinates1 : CLLocationCoordinate2D!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBAction func takePicture(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let title = "Would you like to take a picture or choose one from PhotoLibrary"
            let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
            ac.popoverPresentationController?.sourceView = self.view
            let takePhoto = UIAlertAction(title: "Camera", style: .default) { (alert: UIAlertAction!) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            let useLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alert: UIAlertAction) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction) in
                
            }
            ac.addAction(takePhoto)
            ac.addAction(useLibrary)
            ac.addAction(cancel)
            
            present(ac, animated: true, completion: nil)
            
            
        } else {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
        
        imagePicker.delegate = self
        
    }
    @IBOutlet var ButtonIcon: UIButton!
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    var bar: Bar?
    var barStore : BarStore = BarStore()
    var barArray : [Bar] = []
    var imageStore : ImageStoreController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        navigationItem.title = "Add a new bar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(createNewBar(_:)))
    }
    
    func createNewBar(_ sender: AnyObject) {
        if (nameField.text != "") && addressField.text != "" && imageView.image != nil {
            let myName : String = (nameField?.text)!
            let myAddress : String = (addressField?.text)!
            let myImageName = barStore.imageUploadTo(image: imageView.image!)
            let myLatitude = latitudeUser
            let myLongitude = longitudeUser
            print(myName, myAddress)
            let newBar = Bar(name: myName, address: myAddress, imageName: myImageName, latitude: myLatitude!, longitude: myLongitude!)
            barStore.allBars.append(newBar)
            barStore.uploadTo(bar: newBar)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let title = "Oops!"
            let message = "Seems like you forgot to fill in all the required fields"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let gotTheMessage = UIAlertAction(title: "Try again", style: .default, handler: nil)
            ac.addAction(gotTheMessage)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        ButtonIcon.alpha = 0.05
        let newImage = imageView.image
        barStore.imageUploadTo(image: newImage!)
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.longlat = manager.location!.coordinate
        locationManager.stopUpdatingLocation()
        print("These are the coordinates uploaded to firebase \(self.longlat)")
        coordinates1 = self.longlat
        latitudeUser = self.longlat.latitude
        longitudeUser = self.longlat.longitude
        print(latitudeUser, longitudeUser)
        
    }
}


