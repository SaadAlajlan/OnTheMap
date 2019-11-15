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
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(startOver))
       let reload = UIBarButtonItem(image:#imageLiteral(resourceName: "reload"),style: .plain, target: self, action: #selector(addTapped))
        let location = UIBarButtonItem(image:#imageLiteral(resourceName: "Web.png"), style: .plain, target: self, action: #selector(playTapped))
        
        

        navigationItem.rightBarButtonItems = [reload, location]
        }
     override func viewWillAppear(_ animated: Bool) {

         super.viewWillAppear(animated)


              self.tableView!.reloadData()
         
     }
//    @objc func startOver() {
//
//            let storyboard = UIStoryboard (name: "Main", bundle: nil)
//            let resultVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            navigationController!.pushViewController(resultVC, animated: true)
////         self.tabBarController?.tabBar.isHidden = true
//
//
//
//     }
     @objc func playTapped() {
                      
                let storyboard = UIStoryboard (name: "Main", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigationController!.pushViewController(resultVC, animated: true)
    //         self.tabBarController?.tabBar.isHidden = true
                    

        
         }
     @objc func addTapped() {
                      
                let storyboard = UIStoryboard (name: "Main", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigationController!.pushViewController(resultVC, animated: true)
    //         self.tabBarController?.tabBar.isHidden = true
                    

        
         }
   
}
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return (stuedentsData.students?.results.count)!
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pins")!
         
        let loc = stuedentsData.students!.results[indexPath.row]
         
        cell.textLabel?.text = loc.lastName! + " " + loc.firstName!
         cell.imageView?.image = #imageLiteral(resourceName: "1024")
        
                 
         
         
         return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loc = stuedentsData.students!.results[indexPath.row]
        guard let url = URL(string: loc.mediaURL!) else { return }
        UIApplication.shared.open(url)
     }
}

