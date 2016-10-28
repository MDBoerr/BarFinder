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
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var bar : Bar! {
        didSet {
            navigationItem.title = bar.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = bar?.address
        imageView.image = bar.image
        
    }
    
}
