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
    
    var bar : Bar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // DEtail view wont load when used ->
       // addressLabel.text = bar.address
        
    }
    
}
