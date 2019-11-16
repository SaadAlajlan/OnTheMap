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
        

    }
    @IBAction func signUp(_ sender: Any) {
        guard let url = URL(string: "https://www.udacity.com/account/auth#!/signup") else { return }
        UIApplication.shared.open(url)
        
        
    }
    @IBAction func loginC(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
                   self.setActivityIndicator(isOn: true)
            ParseClient.request(username: emailTextField.text!, password: passwordTextField.text!) { (success, error) in
                       self.setActivityIndicator(isOn: false)
                       if success{
                           DispatchQueue.main.async {

                            self.performSegue(withIdentifier: "showTabBar", sender: self)
                           }
                       }
                       else{
                           self.popupAlert(topic: nil, message: error?.localizedDescription ?? "")
                       }
                   }
               }
               else{
                   self.popupAlert(topic: nil, message: "Empty Email or Password")
               }
        }
    func setActivityIndicator(isOn: Bool){
          if isOn{
              self.activityIndicator.startAnimating()
              UIApplication.shared.beginIgnoringInteractionEvents()
          }
          else{
              self.activityIndicator.stopAnimating()
              self.activityIndicator.hidesWhenStopped = true
              UIApplication.shared.endIgnoringInteractionEvents()
          }
      }

    }
extension UIViewController{
    func actionAlert(topic: String? = nil, message: String? = nil, complition: @escaping(UIAlertAction) -> Void){
        let alert = UIAlertController(title: topic, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: complition))
        self.present(alert, animated: true, completion: nil)
    }
    
    func popupAlert(topic: String? = nil, message: String? = nil){
        let alert = UIAlertController(title: topic, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

  
   
       

