//
//  AddBarController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import MapKit

class AddBarController: UIViewController, UINavigationControllerDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    var mapViewCont : MapViewController!
    var locationManager : CLLocationManager = CLLocationManager()
    var longlat : CLLocationCoordinate2D!
    var latitudeUser : CLLocationDegrees!
    var longitudeUser : CLLocationDegrees!
    var coordinates1 : CLLocationCoordinate2D!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var ratingField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var SaveButton: UIBarButtonItem!
    @IBAction func takePicture(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let title = "Would you like to take a picture or choose one from the PhotoLibrary?"
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
        nameField.delegate = self
        addressField.delegate = self
        ratingField.delegate = self
        
        navigationItem.title = "Add a new bar"
        SaveButton.isEnabled = false
    }
    
    @IBAction func saveButtonEnabled() {
            createNewBar(self)
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (nameField.text != ""), addressField.text != "", imageView.image != nil && ratingField.text != "" {
            SaveButton.isEnabled = true
        } else {
            SaveButton.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == ratingField {
            let wrongCharacter = CharacterSet(charactersIn: "0123456789.,").inverted
            return string.rangeOfCharacter(from: wrongCharacter, options: [], range: string.startIndex ..< string.endIndex) == nil
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createNewBar(_ sender: AnyObject) {
        let myName : String = (nameField?.text)!
        let myAddress : String = (addressField?.text)!
        let myRating : String = (ratingField.text)!
        let myImageName = barStore.imageUploadTo(image: imageView.image!)
        let myLatitude = latitudeUser
        let myLongitude = longitudeUser
        print(myName, myAddress)
        let newBar = Bar(name: myName, address: myAddress, imageName: myImageName, latitude: myLatitude!, longitude: myLongitude!, rating: myRating)
        barStore.allBars.append(newBar)
        barStore.uploadTo(bar: newBar)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = ResizeImage(image: image, targetSize: CGSize(width: 400, height: 400))
        ButtonIcon.alpha = 0.05
//        let newImage = imageView.image
//        barStore.imageUploadTo(image: newImage!)
        dismiss(animated: true, completion: nil)
    }
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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


