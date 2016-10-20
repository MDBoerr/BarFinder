//
//  TableViewController.swift
//  BarFinder
//
//  Created by Michael  de Boer on 10/19/16.
//  Copyright © 2016 EPW. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController  {
    
    var barInfo : [Dictionary<String, String>] = []
    let dataSource = Bar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.createDicts()
        barInfo = dataSource.giveBarArray()
        
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return barInfo.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let currentBar = barInfo[indexPath.row]
        let name = currentBar["Name"]
        let address = currentBar["Address"]
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = address
        cell.imageView?.image = UIImage(named: "MapIcon.png")
        
        return cell
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //                if segue.identifier == "BarDetails" {
    //
    //                    var indexPath = tableView.indexPathForSelectedRow
    //                    let item = barInfo[(indexPath?.row)!]
    //
    //                    let detailViewController = segue.destination as! DetailViewController
    //                    detailViewController.currentBar = item
    //
    //                }
    //        
    //    }
    
}
