//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation

class ParseClient {
  
   class func studentLocation (completion: @escaping ([StudentLocation]?, Error?) -> ()) {
           var request = URLRequest (url: URL (string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
           
           request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
           
           request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
           
           let session = URLSession.shared
           let task = session.dataTask(with: request) {data, response, error in
               if error != nil {
                   
                   completion (nil, error)
                   return
               }
            
                   let studentsLocations = try! JSONDecoder().decode(StudentLocations.self, from: data!)
                   
            completion (studentsLocations.results, nil)
               }
           
           
           task.resume()
       }
}
   


