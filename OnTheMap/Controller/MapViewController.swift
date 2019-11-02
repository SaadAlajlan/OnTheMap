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
           }
     override func viewWillAppear(_ animated: Bool) {
        ParseClient.studentLocation() {(studentsLocations, error) in

            DispatchQueue.main.async {
    
    if error != nil {
        let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
        
        errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
            return
        }))
        self.present(errorAlert, animated: true, completion: nil)
        return
    }
            var annotations = [MKPointAnnotation]()
            
           
            guard let locationsArray = studentsLocations else {
                let locationsErrorAlert = UIAlertController(title: "Erorr loading locations", message: "There was an error loading locations", preferredStyle: .alert )
                               
                locationsErrorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                                   return   }))
                               self.present(locationsErrorAlert, animated: true, completion: nil)
                               return
                           }
             for locationStruct in locationsArray {
                
               
                let lat = CLLocationDegrees(locationStruct.latitude!)
                let long = CLLocationDegrees(locationStruct.longitude!)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = locationStruct.firstName!
                let last = locationStruct.lastName!
                let mediaURL = locationStruct.mediaURL!
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
            
            // When the array is complete, we add the annotations to the map.
            self.mapView.addAnnotations(annotations)
            
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

}
