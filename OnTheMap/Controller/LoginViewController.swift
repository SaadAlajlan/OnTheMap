//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//
import UIKit


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
    @IBAction func loginTapped(_ sender: Any) {
       setLoggingIn(true)
          let username = emailTextField.text!
              let password = passwordTextField.text!
              
              if (username.isEmpty) || (password.isEmpty) {
                  
                  let requiredInfoAlert = UIAlertController (title: "Fill the required fields", message: "Please fill both the email and password", preferredStyle: .alert)
                  
                  requiredInfoAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                      return
                  }))
                  
                  self.present (requiredInfoAlert, animated: true, completion: nil)
                  
              } else {
                
                ParseClient.postSession(email: username, password: password) { (result, error) in
                    if let error = error {
                        let errorAlert = UIAlertController(title: "Erorr performing request", message: error.localizedDescription, preferredStyle: .alert )
                        
                        errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                            return
                        }))
                                    }
                    if let error = result?["error"] as? String {
                        let errorAlert = UIAlertController(title: "Erorr performing request", message: error, preferredStyle: .alert )
                        
                        errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                            return
                        }))
                    }
                    if let session = result?["session"] as? [String:Any], let sessionId = session["id"] as? String {
                        print(sessionId)
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                        

                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    
        
                                    
    
    }
        }
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
