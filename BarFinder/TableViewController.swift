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
    
    
    let barStore = BarStore.sharedInstance
    var bar : Bar?
    var barArray : [Bar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action:#selector(refreshData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
        barStore.downloadFrom { (result: [Bar]) in
            if result.count != 0 {
                self.barArray = result
                self.tableView.reloadData()
                
            }
        }
        let color : UIColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = 80
        
        
        tabBarController?.tabBar.barTintColor = color
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.darkGray
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barStore.allBars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath) as! BarCell
        let currentBar = barStore.allBars[indexPath.row]
        let name = currentBar.name
        let address = currentBar.address
        let rating = currentBar.rating
        
        cell.nameLabel.text = name
        cell.addressLabel.text = address
        cell.imageLabel.image = currentBar.image
        cell.ratingLabel.text = "\(rating)/10"
        DispatchQueue.global().async {
            currentBar.loadImageOn(completion: { (image) in
                DispatchQueue.main.async {
                    cell.imageLabel.image = currentBar.image
                }
            })
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
   //     UIView.animate(withDuration: 1.0)
        UIView.animate(withDuration: 1.0, animations: {
            cell.alpha = 1.0
            
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BarDetails" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = barStore.allBars[row]
                
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.bar = item
                detailViewController.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        print(barStore.allBars.count)
    }
    
    func refreshData() {
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl?.beginRefreshing()
            self.tableView.reloadData()
//            barStore.downloadFrom { (result: [Bar]) in
//                if result.count != 0 {
//                    self.barArray = result
//                    self.tableView.reloadData()
//
//                }
//            }

            self.tableView.refreshControl?.endRefreshing()
        } else {
             //Fallback on earlier versions
        }
        
    }
    
}
