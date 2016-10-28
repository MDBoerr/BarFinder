//
//  AddBarController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddBarController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    var bar: Bar?
    var barStore : BarStore = BarStore()
    var barArray : [Bar] = []
    var imageStore : ImageStoreController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add a new bar"
    }

    
    @IBAction func createNewBar(_ sender: AnyObject) {
        if (nameField.text != "") && addressField.text != "" && imageView.image != nil {
            let myName : String = (nameField?.text)!
            let myAddress : String = (addressField?.text)!
            let myImageName = barStore.imageUploadTo(image: imageView.image!)
            print(myName, myAddress)
            let newBar = Bar(name: myName, address: myAddress, imageName: myImageName)
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
        let newImage = imageView.image
        barStore.imageUploadTo(image: newImage!)
        
        
        dismiss(animated: true, completion: nil)
    }
    
}


