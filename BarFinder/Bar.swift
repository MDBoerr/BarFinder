//
//  Bar.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class Bar : NSObject {
    
    var name : String
    var address : String
    var imageName : String
    var image : UIImage?

    init(name: String, address: String, imageName: String) {
        self.name = name
        self.address = address
        self.imageName = imageName
        
        super.init()
    }
    
}
