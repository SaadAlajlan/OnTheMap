//
//  UIViewController+Additions.swift
//  OnTheMap
//
//  Created by Saad on 11/17/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation
import UIKit

extension LocateOnTheMapViewController{
    
    func setActiveIndicator(isShowed : Bool){
        indicatorView.isHidden = !isShowed
        if isShowed{
            indicatorView.startAnimating()
        }
        else{
            indicatorView.stopAnimating()
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
