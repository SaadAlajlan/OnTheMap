//
//  LocateOnTheMapViewController.swift
//  OnTheMap
//
//  Created by Saad on 11/16/19.
//  Copyright © 2019 saad. All rights reserved.
//


import UIKit
import MapKit

class LocateOnTheMapViewController: UIViewController,UITextFieldDelegate, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var urlField: UITextField!
    var annotation: MKPointAnnotation?
    
    var annotationView: MKAnnotationView?
    override func viewDidLoad() {
        DispatchQueue.main.async {
            
            super.viewDidLoad()
            self.urlField.delegate = self
            self.setActiveIndicator(isShowed: true)
            self.getLocation()
            self.mapView.delegate = self
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func updatePostLocation(latitude: Double, longitude: Double){
        ParseClient.Auth.userPosted.latitude = latitude
        ParseClient.Auth.userPosted.longitude = longitude
    }
    
    func getLocation(){
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(ParseClient.Auth.userPosted.mapString) { (placemarks, error) in
            
            self.setActiveIndicator(isShowed: false)
            if error != nil{
                self.actionAlert(topic: "Location not found!", message: nil, complition: { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                })
            }
            else if let placemarks = placemarks{
                
                if placemarks.count > 0{
                    
                    self.updatePostLocation(latitude: (placemarks[0].location?.coordinate.latitude)!, longitude: (placemarks[0].location?.coordinate.longitude)!)
                    DispatchQueue.main.async {
                        self.pointToLocation()
                    }
                }
                else {
                    self.actionAlert(topic: "Location not found!", message: nil, complition: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }
            else {
                self.actionAlert(topic: "Location not found!", message: nil, complition: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        
        if urlField.text != ""{
            
            ParseClient.Auth.userPosted.mediaURL = urlField.text ?? ""
            ParseClient.postLocation(completion: handleLocationResponse(success:error:))
            
        }
        else{
            self.popupAlert(topic: nil, message: "Location and link cannot be empty")
        }
    }
    func handleLocationResponse(success: Bool, error: Error?){
        if success{
            self.actionAlert(topic: "Successful", message: "Location Added") { (action) in
                let storyboard = UIStoryboard (name: "Main", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                self.navigationController!.pushViewController(resultVC, animated: true)
            }
        }
        else{
            self.popupAlert(topic: "Failed", message: "Please try again")
        }
    }
    func pointToLocation(){
        annotation = MKPointAnnotation()
        annotation!.coordinate = CLLocationCoordinate2D(latitude:
            ParseClient.Auth.userPosted.latitude, longitude:
            ParseClient.Auth.userPosted.longitude)
        annotation!.title = ParseClient.Auth.userPosted.mapString
        annotation!.subtitle = ParseClient.Auth.userPosted.mediaURL
        mapView.addAnnotation(annotation!)
        
        mapView.setRegion(MKCoordinateRegion(center: annotation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)), animated: false)
    }
    
}
extension LocateOnTheMapViewController{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        if annotation is MKUserLocation{
            return nil
        }
        annotationView?.canShowCallout = true
        annotationView?.isDraggable = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        let location = view.annotation?.coordinate
        ParseClient.Auth.userPosted.latitude = location!.latitude
        ParseClient.Auth.userPosted.longitude = location!.longitude
        self.updatePostLocation(latitude: location!.latitude, longitude: location!.longitude)
    }
}
