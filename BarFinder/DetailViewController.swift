//
//  DetailViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentBar : Dictionary<String, String> = [:]
   
    @IBOutlet var addressLabel: UILabel!
    
    var bar : BarCell! {
        //Setting the title in the navigationbar (doesn't give the value yet)
        didSet {
            navigationItem.title = currentBar["Name"]
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //AddressLabel is linked properly now but doesn't show the right value yet..
        
        addressLabel.text = currentBar["Address"]
        
    }
    
}
