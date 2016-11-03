//
//  BarStore.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class BarStore {
    
    static let sharedInstance = BarStore()
    
    var allBars : [Bar] = []
    var ref: FIRDatabaseReference!
    var gsRef : FIRStorageReference!
    var currentBar : Bar?
    
    
    func giveBarArray() -> [Bar] {
        return allBars
    }
    
    func uploadTo(bar: Bar)  {
        ref = FIRDatabase.database().reference()
        
        let name = bar.name
        let address = bar.address
        let imageName = bar.imageName
        let latitude = bar.latitude
        let longitude = bar.longitude
        let rating = bar.rating
        //  let image = bar.image
        _ = ref.child("Bars").child(name).setValue(["Name" : name, "Address" : address, "ImageName" : imageName, "Latitude" : latitude, "Longitude" : longitude, "Rating" : rating])
        
    }
    
    func downloadFrom(completion: @escaping ([Bar]) -> ()) {
        ref = FIRDatabase.database().reference()
        
        ref.child("Bars").observe(.value, with: { (snapshot) in
            self.allBars = []
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let barDict = snap.value as? Dictionary<String, Any> {
                        let barName = barDict["Name"] as! String
                        let barAddress = barDict["Address"] as! String
                        let barImageName = barDict["ImageName"] as! String
                        let barLatitude = barDict["Latitude"] as! Double
                        let barLongitude = barDict["Longitude"] as! Double
                        let barRating = barDict["Rating"] as! String
                       // let gsRef = FIRStorage.storage().reference(forURL: "gs://barfinder2-a4ffa.appspot.com/Images/")
                        
                        
                        let bar = Bar(name: barName, address: barAddress, imageName: barImageName, latitude: barLatitude, longitude: barLongitude, rating: barRating)
                        self.allBars.append(bar)
                        
                        let notification = Notification.Name("Data arrived")
                        NotificationCenter.default.post(name: notification, object: nil)
                    }
                }
                completion(self.allBars)
            }
        })}
    
    
    func imageUploadTo(image: UIImage) -> String {
        let gsRef = FIRStorage.storage().reference(forURL: "gs://barfinder2-a4ffa.appspot.com/Images/")
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        let imageName = "\(Date().timeIntervalSince1970).jpeg"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        gsRef.child(imageName).put(imageData!, metadata: metaData) { (metaData, error) in
            if let error = error {
                print("Error Uploading: \(error)")
                return
            }
        }
        return imageName
    }
}
