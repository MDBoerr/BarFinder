//
//  BarStore.swift
//  BarFinder
//
//  Created by Ewoud Wortelboer on 19/10/2016.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class BarStore {
    
    var allBars : [Bar] = []
    
    func createBar() -> Bar {
        let newBar = Bar()
        
        allBars.append(newBar)
        
        return newBar
    }

        
        
}
