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
                      
    
           
            }
      
    @objc func addLocationTapped() {
//
    }
      
    @objc func logoutTapped() {
                            
           

              
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
                         DispatchQueue.main.async {
                             
                           
    }
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
           
           // This delegate method is implemented to respond to taps. It opens the system browser
           // to the URL specified in the annotationViews subtitle property.
        
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
               
               if control == view.rightCalloutAccessoryView {
                   let app = UIApplication.shared
                   if let toOpen = view.annotation?.subtitle! {
                       app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
                   }
               }
           }
       
}
