//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
        
        @IBOutlet weak var mapView: MKMapView!
        
    var annotationView: MKAnnotationView?
    var annotations: [MKAnnotation] = []
    var selectLink = ""
    
    override func viewDidLoad() {
               super.viewDidLoad()
               mapView.delegate = self
               barItems()
           }
           
         
    override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
        locations()
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
                      
   mapView.removeAnnotations(annotations)
     annotations.removeAll()
     ParseClient.Auth.userList.removeAll()
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
    func loadAllAnnotations(){
    for location in ParseClient.Auth.userList{
        let annotation = MKPointAnnotation()
        annotation.title = "\(location.firstName) \(location.lastName)"
        annotation.subtitle = location.mediaURL
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotations.append(annotation)
    }
    }
    
        
        
        
    func handleLocationsResponse(data: StudentLocations?, error: Error?){
        if let data = data{
            ParseClient.Auth.userList.removeAll()
            for user in data.results{
                ParseClient.Auth.userList.append(user)
            }
            self.loadAllAnnotations()
            self.mapView.addAnnotations(self.annotations)
        }
        else{
            self.popupAlert(topic: "Download Failed", message: error?.localizedDescription ?? "")
        }
    }
        
        
   
    func locations(){
        ParseClient.getLocations(url: URL(string: API.MAIN + "StudentLocation?limit=100&order=-updatedAt")!, completion: handleLocationsResponse(data:error:))
        }
    

         
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
               
               let reuseId = "pin"
               
               var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
               
               if pinView == nil {
                   pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                   pinView!.canShowCallout = true
                   pinView!.pinTintColor = .red
                   pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               }
               else {
                   pinView!.annotation = annotation
               }
               
               return pinView
           }
           
           
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
               
               if control == view.rightCalloutAccessoryView {
                   let app = UIApplication.shared
                   if let toOpen = view.annotation?.subtitle! {
                       app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
                   }
               }
           }
       
}
