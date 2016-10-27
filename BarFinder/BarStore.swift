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
    
    static let sharedInstance = BarStore.self
    
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
        let image = bar.image
        _ = ref.child("Bars").child(name).setValue(["Name" : name, "Address" : address, "Image": image])
        
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
                        let barImage = barDict["Image"] as! String
                        let bar = Bar(name: barName, address: barAddress, image: barImage)
                        self.allBars.append(bar)
                    }
                    
                }
            }
            completion(self.allBars)
        })}
    
    func imageUploadTo(image: UIImage) -> String {
        let gsRef = FIRStorage.storage().reference(forURL: "gs://barfinder-fc3ee.appspot.com/Images/")
        
        let imageData = UIImageJPEGRepresentation(image, 0.5)
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
    
    func imageDownloadFrom() {
        let downloadRef = gsRef.child(currentBar!.image)
        downloadRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                // ... let islandImage: UIImage! = UIImage(data: data!)
                print("Download: \(downloadRef)")
            }
        }
    }
}
