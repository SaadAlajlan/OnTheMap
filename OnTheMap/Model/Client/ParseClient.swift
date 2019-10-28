//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation

class ParseClient {
  
   
 class func requestBreedsList(completionHandler: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
        guard let data = data else {
            completionHandler(false, error)
            return
        }
        
        do{
            let decoder = JSONDecoder()
           let responseObject = try decoder.decode(StudentLocation.self, from: data)
           print(responseObject)
            completionHandler(true, nil)
        } catch {
            completionHandler(false, error)
        }
        
    }
    task.resume()
}
}
