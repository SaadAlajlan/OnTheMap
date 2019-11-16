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
        barItems()
    
   
        }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        locations()
        
        self.tableView!.reloadData()
         
     }

    
    func barItems(){
          
        let reload = UIBarButtonItem(image:#imageLiteral(resourceName: "reload"),style: .plain, target: self, action: #selector(reloadTapped))
          
        let location = UIBarButtonItem(image:#imageLiteral(resourceName: "Web.png"), style: .plain, target: self, action: #selector(addLocationTapped))
            
        let logout = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logoutTapped))
           
           

          
        navigationItem.title = "OnTheMap"
        
        navigationItem.rightBarButtonItems = [reload, location]
        
        reload.tintColor = .gray
        
        location.tintColor = .gray
      
        navigationItem.leftBarButtonItem = logout
      
        logout.tintColor = .gray
       }
   
    @objc func reloadTapped() {
                      
                ParseClient.getLocations(url: URL(string: API.MAIN + "StudentLocation?limit=100&order=-updatedAt")!, completion: handleLocationsResponse(data:error:))
                            
         }
   
    @objc func addLocationTapped() {
                  
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
                    
        let resultVC = storyboard.instantiateViewController(withIdentifier: "NewLocationViewController") as! NewLocationViewController
                                
        navigationController!.pushViewController(resultVC, animated: true)
        self.tabBarController?.tabBar.isHidden = true
          
         }
   
    @objc func logoutTapped() {
                
        ParseClient.Auth.key = ""
          
        ParseClient.Auth.sessionId = ""
       
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                            
           
            }
   
        func handleLocationsResponse(data: StudentLocations?, error: Error?){
             if let data = data{
                 ParseClient.Auth.userList.removeAll()
                 for user in data.results{
                     ParseClient.Auth.userList.append(user)
                 }
                 tableView.reloadData()
             }
             else{
                 self.popupAlert(topic: "Download Failed", message: error?.localizedDescription ?? "")
             }
         }
   func locations(){
             ParseClient.getLocations(url: URL(string: API.MAIN + "StudentLocation?limit=100&order=-updatedAt")!, completion: handleLocationsResponse(data:error:))
               
}
}
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return ParseClient.Auth.userList.count
     }
     
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pins")!
         
        let loc = ParseClient.Auth.userList[indexPath.row]
         
        cell.textLabel?.text = loc.lastName + " " + loc.firstName
         cell.imageView?.image = #imageLiteral(resourceName: "1024")
        
                 
         
         
         return cell
     }
     
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loc = ParseClient.Auth.userList[indexPath.row]
        guard let url = URL(string: loc.mediaURL) else { return }
        UIApplication.shared.open(url)
     }
}

