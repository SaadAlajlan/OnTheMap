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
//       let long = CLLocationDegrees (coordinate.longitude)
//             
//             let lat = CLLocationDegrees (coordinate.latitude)
//              let coords = CLLocationCoordinate2D (latitude: lat, longitude: long)
//        let mediaURL = mediaURL
//                                             
//                                             
//             let first = firstName
//                                             
//                                            
//             let last =  lastName
//                 
//        ParseClient.PostStudentLocation(link: mediaURL, coordinate: coords, location: <#T##String#>, completion: <#T##(Error?) -> ()#>)
             
            }
      
    @objc func logoutTapped() {
                            
           

              
               }
    func locations(){
        ParseClient.getStudentLocation{(studentsLocations, error) in
                         DispatchQueue.main.async {
                             
                             if error != nil {
                                 let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
                                 
                                 errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                                     return
                                 }))
                                 self.present(errorAlert, animated: true, completion: nil)
                                 return
                             }
                             
                             var annotations = [MKPointAnnotation] ()
                             
                             guard let locationsArray = studentsLocations else {
                                 let locationsErrorAlert = UIAlertController(title: "Erorr loading locations", message: "There was an error loading locations", preferredStyle: .alert )
                                 
                                 locationsErrorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                                     return
                                 }))
                                 self.present(locationsErrorAlert, animated: true, completion: nil)
                                 return
                             }
                             
                             
                             for locationStruct in locationsArray {
                                 
                                 let long = CLLocationDegrees (locationStruct.longitude ?? 0)
                                 let lat = CLLocationDegrees (locationStruct.latitude ?? 0)
                                 
                                 let coords = CLLocationCoordinate2D (latitude: lat, longitude: long)
                                 
                                 
                                 let mediaURL = locationStruct.mediaURL ?? " "
                                 
                                 
                                 let first = locationStruct.firstName ?? " "
                                 
                                
                                 let last = locationStruct.lastName ?? " "
                                 
                                 // Here we create the annotation and set its coordiate, title, and subtitle properties
                                 let annotation = MKPointAnnotation()
                                 annotation.coordinate = coords
                                 annotation.title = "\(first) \(last)"
                                 annotation.subtitle = mediaURL
                                 
                                 annotations.append (annotation)
                             }
                             self.mapView.addAnnotations (annotations)
                         }
                         
                     }//end parse
    }
    
//    func addNewLocation(firstName: String, lastName: String, mediaURL: String,coordinate: CLLocationCoordinate2D){
//
//        var annotations = [MKPointAnnotation] ()
//
//
//
//
//
//        let annotation = MKPointAnnotation()
//
//        annotation.coordinate = coords
//
//        annotation.title = "\(first) \(last)"
//
//        annotation.subtitle = mediaURL
//
//        annotations.append (annotation)
//    }
          
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
