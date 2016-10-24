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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 'Save' changes to item
        bar.name = nameField.text ?? ""
        
    }
    
    
    
}
