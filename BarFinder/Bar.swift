//
//  Bar.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class Bar : NSObject{
    
    var name : String = " "
    var address : String = " "
    
    var barArray = [Dictionary<String, String>]()
    
    func createDicts() {
        
        let barDict1 = ["Name" : "Bar One", "Address" : "Address One"]
        
        let barDict2 = ["Name" : "Bar Two", "Address" : "Address Two"]
        
        let barDict3 = ["Name" : "Bar Three", "Address" : "Address Three"]
        
        let barDict4 = ["Name" : "Bar Four", "Address" : "Address Four"]
        
        let barDict5 = ["Name" : "Bar Five", "Address" : "Address Five"]
        
        barArray = [barDict1, barDict2, barDict3, barDict4, barDict5]
        
    }
    
    func giveBarArray() -> [Dictionary<String, String>] {
        return barArray
    }
    
}
