//
//  AddBarController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class AddBarController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    
    var bar: Bar?
    var barStore : BarStore = BarStore()
    var barArray : [Bar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func createNewBar(_ sender: AnyObject) {
        if (nameField.text != "") && addressField.text != "" {
            let myName : String = (nameField?.text)!
            let myAddress : String = (addressField?.text)!
            print(myName, myAddress)
            let newBar = Bar(name: myName, address: myAddress)
            barStore.allBars.append(newBar)
            barStore.uploadTo(bar: newBar)
            self.navigationController?.popViewController(animated: true)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
