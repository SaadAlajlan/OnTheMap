//
//  NewLocationViewController.swift
//  OnTheMap
//
//  Created by Saad on 11/16/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation
import UIKit

class NewLocationViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var FindLocation: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
       
    
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    @IBAction func findOnTheMap(_ sender: Any) {
        if FindLocation.text != "" {
            ParseClient.Auth.userPosted.mapString = FindLocation.text!
           
            performSegue(withIdentifier: "ShowLocation", sender: self)
        }
        else{
            self.popupAlert(topic: nil, message: "Location and link cannot be empty")
        }
    }
}

