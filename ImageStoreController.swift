//
//  ImageStoreController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class ImageStoreController : UIImagePickerController {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as AnyObject) as? UIImage
    }
    
    func deleteForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
    }
    
}
