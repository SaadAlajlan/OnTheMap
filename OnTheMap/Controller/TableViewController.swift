//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        }
     override func viewWillAppear(_ animated: Bool) {

         super.viewWillAppear(animated)


              self.tableView!.reloadData()
         
     }
   
}
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 100
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pins")!
         
        let loc = stuedentsData.students!.results[indexPath.row]
         
        cell.textLabel?.text = loc.lastName! + " " + loc.firstName!
         cell.imageView?.image = UIImage(named: "loc")
        
                 
         
         
         return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loc = stuedentsData.students!.results[indexPath.row]
        guard let url = URL(string: loc.mediaURL!) else { return }
        UIApplication.shared.open(url)
     }
}

