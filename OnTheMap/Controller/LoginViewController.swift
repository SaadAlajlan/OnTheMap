//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//
import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    @IBAction func loginTapped(_ sender: UIButton) {
       setLoggingIn(true)
        
    }
    func setLoggingIn(_ loggingIn: Bool) {
           if loggingIn {
               activityIndicator.startAnimating()
           } else {
               activityIndicator.stopAnimating()
           }
           emailTextField.isEnabled = !loggingIn
           passwordTextField.isEnabled = !loggingIn
           loginButton.isEnabled = !loggingIn
         
       }
   
       
}
