//
//  DetailViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import Firebase


class DetailViewController: UIViewController {
    
    let barStore : BarStore! = BarStore()
    let barCellNameLabel = BarCell().nameLabel
    let barCellAddress  = BarCell().addressLabel
   
    @IBOutlet var addressLabel: UILabel!
    
    var bar : Bar! {
        //Setting the title in the navigationbar (doesn't give the value yet)
        didSet {
            navigationItem.title = bar.name
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //AddressLabel is linked properly now but doesn't show the right value yet..
        
        addressLabel.text = bar?.address
        
    }

     
        

}
