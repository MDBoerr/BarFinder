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
    var ref: FIRDatabaseReference!
    var storeRef : FIRStorageReference!
    var storage = FIRStorage.storage()
    let gsRef = FIRStorage.storage().reference(forURL: "gs://barfinder-fc3ee.appspot.com")
    
    func giveBarArray() -> [Bar] {
        return allBars
    }
    func uploadTo(bar: Bar)  {
        ref = FIRDatabase.database().reference()
        
        let name = bar.name
        let address = bar.address
        //let image = bar.image
        let barRef = ref.child("Bars").child(bar.name).setValue(["Name" : name, "Address" : address])
    
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

}
