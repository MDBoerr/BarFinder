//
//  Bar.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseStorage

class Bar : NSObject {
    
    var name : String
    var address : String
    var imageName : String
    var image : UIImage?
    var longitude : Double
    var latitude : Double
    var completionBlock : ((_ image: UIImage?) -> Void)?
    
    
    init(name: String, address: String, imageName: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.imageName = imageName
        self.latitude = latitude
        self.longitude = longitude
        self.image = nil
        super.init()
        DispatchQueue.global().async {
            if let url=NSURL(string: imageName) {
                self.getItDownloadIt(url: url)
            }
        }
    }
    
    
    func getItDownloadIt (url: NSURL) {
        let gsRef = FIRStorage.storage().reference(forURL: "gs://barfinder-fc3ee.appspot.com/Images/")
        let downloadRef = gsRef.child(self.imageName)
        var downloadImage : UIImage!
        downloadRef.data(withMaxSize: 4 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                downloadImage = UIImage(data: data!)
                print("Download: \(downloadRef)")
                self.image = downloadImage
                if let block = self.completionBlock {
                    print("Loading image \(self.name)")
                    block(downloadImage)
                }
            }
        }
        
    }
    func loadImageOn( completion:@escaping (_ image: UIImage?) -> Void) {
        self.completionBlock = completion
        if self.image != nil {
            completion(self.image)
        }
        
    }
}
