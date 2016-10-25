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
    
    var allBars : [Bar] = []
    var detailBar : Bar?
    
    var ref: FIRDatabaseReference!
    
//    func createBar() {
//        
//        let barDict1 = Bar(name: "bar1", address: "adress 1")
//        let barDict2 = Bar(name: "bar2", address: "adress 2")
//        let barDict3 = Bar(name: "bar3", address: "adress 3")
//        let barDict4 = Bar(name: "bar4", address: "adress 4")
//        let barDict5 = Bar(name: "bar5", address: "adress 5")
//        
//        allBars = [barDict1, barDict2, barDict3, barDict4, barDict5]
//        
//    }
    
    func giveBarArray() -> [Bar] {
        return allBars
    }
    func uploadTo(bar: Bar)  {
        ref = FIRDatabase.database().reference()
        
        let name = bar.name
        let address = bar.address
        let barRef = ref.child("Bars").childByAutoId().setValue(["Name" : name, "Address" : address])
      //  let refName = barDictRef.
        
    }
    
}
