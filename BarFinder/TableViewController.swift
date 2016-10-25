//
//  TableViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController  {
    
    let barStore: BarStore! = BarStore()
    var bar : Bar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barStore.downloadFrom { (result: [Bar]) in
            if result.count != 0 {
                self.barStore.allBars = result
                self.tableView.reloadData()
            }
        }
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return barStore!.allBars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath) as! BarCell
        let currentBar = barStore.allBars[indexPath.row]
        let name = currentBar.name
        let address = currentBar.address
        
        cell.nameLabel.text = name
        cell.addressLabel.text = address
        cell.imageView?.image = UIImage(named: "MapIcon.png")
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BarDetails" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = barStore?.allBars[row]
                
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.bar = item
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(barStore.allBars.count)
    }
    
}
