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
    var detailBar : Bar!
    
    var ref: FIRDatabaseReference!
    
    //    func createBar() {
    //
    //        let barDict1 = Bar(name: "bar1", address: "address 1")
    //        let barDict2 = Bar(name: "bar2", address: "address 2")
    //        let barDict3 = Bar(name: "bar3", address: "address 3")
    //        let barDict4 = Bar(name: "bar4", address: "address 4")
    //        let barDict5 = Bar(name: "bar5", address: "address 5")
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
        let barRef = ref.child("Bars").child(bar.name).setValue(["Name" : name, "Address" : address])
        //  let refName = barDictRef.
        
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
                        let bar = Bar(name: barName, address: barAddress)
                        self.allBars.append(bar)
                    }
                    
                }
            }
            completion(self.allBars)
        })}
    
    //    func getStores(completion: @escaping ([Store]) -> ())  {
    //    var ref: FIRDatabaseReference!
    //
    //
    //    ref = FIRDatabase.database().reference().child("stores")
    //
    //
    //    ref.observe(.value, with: { snapshot in
    //    self.storeCollection = []
    //    if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
    //    for snap in snapshots {
    //    if let storeDict = snap.value as? Dictionary<String, Any> {
    //
    //    let store = Store(name: storeDict["name"] as! String,
    //    houseNumber: snap.key,
    //    description: storeDict["description"] as! String,
    //    latitude: storeDict["latitude"] as! Double,
    //    longitude: storeDict["longitude"] as! Double,
    //    category: storeDict["category"] as! String,
    //    image: storeDict["image"] as! String)
    //    self.storeCollection.append(store)
    //    
    //    }
    //    }
    //    }
    //    
    //    completion(self.storeCollection)
    //    })
    //}
}
