//
//  Bar.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class Bar {
    
//    var barName : String = " "
//    var barAddress : String = " "
//    var barZipCode : String = " "
//    var barTimeSchedule : String = " "
    
    var barArray = [Dictionary<String, String>]()
    
    func createDicts() {
    
    let barDict1 = ["Name" : "Bar One", "Address" : "Address One", "Zip code" : "Zip code one", "Time schedule" : "Time schedule one"]
    
    let barDict2 = ["Name" : "Bar Two", "Address" : "Address Two", "Zip code" : "Zip code two", "Time schedule" : "Time schedule two"]
    
    let barDict3 = ["Name" : "Bar Three", "Address" : "Address Three", "Zip code" : "Zip code three", "Time schedule" : "Time schedule three"]
    
    barArray = [barDict1, barDict2, barDict3]
    
    }
    
    func giveBarArray() -> [Dictionary<String, String>] {
        return barArray
    }
    
}
