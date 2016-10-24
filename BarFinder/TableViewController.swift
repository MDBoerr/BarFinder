//
//  TableViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    var barInfo : [Dictionary<String, String>] = []
    let dataSource = Bar()
    let barStore: BarStore! = BarStore()
    
//    let rootRef = FIRDatabase.database().reference(withPath: "Bars")
//    let barCell : BarCell! = BarCell()
//    let barCellNameLabel = BarCell().nameLabel
//    let barCellAddress  = BarCell().addressLabel
    
    @IBAction func addNewBar(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.createDicts()
        barInfo = dataSource.giveBarArray()
        
        
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = 80
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return barStore.allBars.count
        return barInfo.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath) as! BarCell
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
      //  let item = barStore.allBars[indexPath.row]
//
        let currentBar = barInfo[indexPath.row]
//        
        let name = currentBar["Name"]
        let address = currentBar["Address"]
//        
        cell.nameLabel.text = name
        cell.addressLabel.text = address
        cell.imageView?.image = UIImage(named: "MapIcon.png")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BarDetails" {
            
            var indexPath = tableView.indexPathForSelectedRow
            let item = barInfo[(indexPath?.row)!]
            //let item = barStore.allBars[(indexPath?.row)!]
            
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.currentBar = item
            
        }
    }
//        func viewDidAppear(animated: Bool) {
//            super.viewDidAppear(animated)
//            let rootRef = FIRDatabase.database().reference(withPath: "Bars")
//            let conditionRef = rootRef.child("BarInfo")
//            conditionRef.observe(.value) { (snap: FIRDataSnapshot) in
//                self.barCellNameLabel?.text = (snap.value as! String).description
    
                
                
        
        
}
