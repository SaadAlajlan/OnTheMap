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
        let reload = UIBarButtonItem(image:#imageLiteral(resourceName: "reload"),style: .plain, target: self, action: #selector(addTapped))
        let location = UIBarButtonItem(image:#imageLiteral(resourceName: "Web.png"), style: .plain, target: self, action: #selector(playTapped))
        
        

        navigationItem.rightBarButtonItems = [reload, location]
           }
           
           override func viewWillAppear(_ animated: Bool) {
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
                       
                       //Loop through the array of structs and get locations data from it so they can be displayed on the map
                       for locationStruct in locationsArray {
                           
                           let long = CLLocationDegrees (locationStruct.longitude ?? 0)
                           let lat = CLLocationDegrees (locationStruct.latitude ?? 0)
                           
                           let coords = CLLocationCoordinate2D (latitude: lat, longitude: long)
                           
                           //TODO: Get the media URL and call it mediaURL, if it's nil its value should be " ", for that use Nil-Coalescing Operator (??)
                           let mediaURL = locationStruct.mediaURL ?? " "
                           
                           //TODO: Get the first name and call it first, if it's nil its value should be " ", for that use Nil-Coalescing Operator (??)
                           let first = locationStruct.firstName ?? " "
                           
                           //TODO: Get the last name and call it last, if it's nil its value should be " ", for that use Nil-Coalescing Operator (??)
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
                   
               }//end getAllLocations
           }
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
