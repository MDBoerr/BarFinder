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

    var bar: Bar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 // add view wont load when used ->       
//        nameField.text = bar.name
//        
//        addressField.text = bar.address
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        //save changes to item 
//        bar.name = bar.text ?? ""
//        
//    }
    
    
    
}
