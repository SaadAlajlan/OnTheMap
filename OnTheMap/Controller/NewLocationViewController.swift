//
//  NewLocationViewController.swift
//  OnTheMap
//
//  Created by Saad on 11/16/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation
import UIKit

class NewLocationViewController: UIViewController{
    
    
    
    @IBOutlet weak var FindLocation: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTapAround()
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
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension UIViewController{
    func hideKeyboardWhenTapAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
