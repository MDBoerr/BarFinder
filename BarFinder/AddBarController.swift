//
//  AddBarController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class AddBarController: UIViewController {
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    
    var bar: Bar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 // add view wont load when used ->       
//        nameTextField.text = bar.name
//        
//        addressTextField.text = bar.address
    }
    
    
    
}
