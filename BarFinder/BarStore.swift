//
//  BarStore.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import Foundation
import UIKit

class BarStore {
    
    var allBars : [Bar] = []
    

    
    func createBar() {
        
        let barDict1 = Bar(name: "bar1", address: "adress 1")
        let barDict2 = Bar(name: "bar2", address: "adress 2")
        let barDict3 = Bar(name: "bar3", address: "adress 3")
        let barDict4 = Bar(name: "bar4", address: "adress 4")
        let barDict5 = Bar(name: "bar5", address: "adress 5")

        
        
        allBars = [barDict1, barDict2, barDict3, barDict4, barDict5]
        
    }
    
    func giveBarArray() -> [Bar] {
        return allBars
    }
    

    
//    func createBar() -> Bar {
//        let newBar = Bar(name: name, address: address)
//        
//        allBars.append(newBar)
//        
//        return newBar
//    }

        
    
}
