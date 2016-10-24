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
    
    var currentBar : Dictionary<String, String> = [:]
    let barStore : BarStore! = BarStore()
    let dataSource = Bar()
    let barCell : BarCell! = BarCell()
    let barCellNameLabel = BarCell().nameLabel
    let barCellAddress  = BarCell().addressLabel
   
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
//    override func viewDidLoad() {
//        let rootRef = FIRDatabase.database().reference()
//        let barInfo = dataSource.giveBarArray()
//        
//        rootRef.child("Bars").observe(.childAdded, with: { snapshot in
//            let name = snapshot.value!["Name"]
//        
//        
//        })
//        dataSource.createDicts()
//    }
//    func post() {
//        
//    }
    
    
}
