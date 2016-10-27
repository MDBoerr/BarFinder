//
//  AddBarController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class AddBarController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBAction func takePicture(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
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
        
    }
    @IBAction func createNewBar(_ sender: AnyObject) {
        if (nameField.text != "") && addressField.text != "" {
            let myName : String = (nameField?.text)!
            let myAddress : String = (addressField?.text)!
            let myImage = barStore.imageUploadTo(image: imageView.image!)
            print(myName, myAddress)
            let newBar = Bar(name: myName, address: myAddress, image: myImage)
            barStore.allBars.append(newBar)
            barStore.uploadTo(bar: newBar)
            self.navigationController?.popViewController(animated: true)
        } else {
            let title = "Oops!"
            let message = "Seems like you forgot to fill in a correct value"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let gotTheMessage = UIAlertAction(title: "Try again", style: .default, handler: nil)
            ac.addAction(gotTheMessage)
            
            present(ac, animated: true, completion: nil)
            //self.navigationController?.popViewController(animated: true)
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
