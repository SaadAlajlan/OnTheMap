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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        emailTextField.text = ""
//        passwordTextField.text = ""
    }
    @IBAction func loginC(_ sender: Any) {
             let username = emailTextField.text!
             let password = passwordTextField.text!
             
             if (username.isEmpty) || (password.isEmpty) {
                 
                 let requiredInfoAlert = UIAlertController (title: "Fill the required fields", message: "Please fill both the email and password", preferredStyle: .alert)
                 
                 requiredInfoAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                     return
                 }))
                 
                 self.present (requiredInfoAlert, animated: true, completion: nil)
                 
             } else {
                 
                 ParseClient.postSession(email: username, password: password){(loginSuccess, key, error) in
                     //TODO: Execute the entire code inside the completion body on the main thread asynchronous
                     DispatchQueue.main.async {
                         
                         if error != nil {
                             let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
                             
                             errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                                 return
                             }))
                             self.present(errorAlert, animated: true, completion: nil)
                             return
                         }
                         
                         if !loginSuccess {
                             let loginAlert = UIAlertController(title: "Erorr logging in", message: "incorrect email or password", preferredStyle: .alert )
                             
                             loginAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                                 return
                             }))
                             self.present(loginAlert, animated: true, completion: nil)
                         } else {
                             let controller = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                             self.navigationController!.pushViewController(controller, animated: true)
                             //In on the map, you need to use the key to call a function in the API class to get the user's first name and last name, but here we're just printing the key. So, in your app, instead of printing it, you'll call that function and be passing it as an argument to that function.
                            
                             print ("the key is \(key)")
                         }
                     }}
             }
        }

    }
    //func setLoggingIn(_ loggingIn: Bool) {
//           if loggingIn {
//               activityIndicator.startAnimating()
//           } else {
//               activityIndicator.stopAnimating()
//           }
//           emailTextField.isEnabled = !loggingIn
//           passwordTextField.isEnabled = !loggingIn
//           loginButton.isEnabled = !loggingIn
//
//       }
   
       

