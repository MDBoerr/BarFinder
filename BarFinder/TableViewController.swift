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
    var barArray : [Bar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
       // refreshControl?.tintColor = .white
        refreshControl?.addTarget(self, action:#selector(refreshData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
        barStore.downloadFrom { (result: [Bar]) in
            if result.count != 0 {
                self.barArray = result
                self.tableView.reloadData()
            }
        }
//        barStore.imageDownloadFrom { (result:[Bar]) in
//            if result.count != 0 {
//                self.barStore.allBars = result
//            }
//        }

        

       // let color = UIColor.init(red: 0.1, green: 0.4, blue: 0.390, alpha: 0)
        let color : UIColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
        let color2 : UIColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = 80
        //tableView.backgroundColor = color2
        
        
        tabBarController?.tabBar.barTintColor = color
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        tabBarController?.tabBar.tintColor = UIColor.white

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return barStore!.allBars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath) as! BarCell
        let currentBar = barStore.allBars[indexPath.row]
        let name = currentBar.name
        let address = currentBar.address
        let image = currentBar.image
        
        cell.nameLabel.text = name
        cell.addressLabel.text = address
        cell.imageView?.image = image
        
        
        
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
        self.tableView.reloadData()

        print(barStore.allBars.count)
    }
    func refreshData() {
        self.tableView.reloadData()
//        
//        self.tableView.refreshControl?.beginRefreshing()
//        self.tableView.reloadData()
//
//        self.tableView.refreshControl?.endRefreshing()
        
    }
    
}
