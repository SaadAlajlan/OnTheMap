//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//

import UIKit
import MapKit

class ParseClient {
    
    
class func postSession(email: String, password : String, completion: @escaping([String:Any]?, Error?) -> Void){
    var request = URLRequest (url: URL (string: "https://onthemap-api.udacity.com/v1/session")!)
              request.httpMethod = "POST"
              request.addValue("application/json", forHTTPHeaderField: "Accept")
              request.addValue("application.json", forHTTPHeaderField: "Content-Type")
                request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
              let session = URLSession.shared
              let task = session.dataTask(with: request) {data, response, error in
                  if error != nil {
                      
                      completion (nil, error)
                      return
                  }
                let range = 5..<data!.count
               let newData = data?.subdata(in: range)
             let response1 = try! JSONSerialization.jsonObject(with: newData!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            
               completion (response1, nil)
                  }
              
              
              task.resume()
    
          }
    
    class func deleteSession(completion: @escaping (Error?) -> Void){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          let range = 5..<data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }



    class func PostStudentLocation (link: String, coordinate: CLLocationCoordinate2D, location: String, completion: @escaping ( Error?) -> ()) {
        var request = URLRequest (url: URL (string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(location)\", \"mediaURL\": \"\(link)\",\"latitude\": \(coordinate.latitude), \"longitude\": \(coordinate.longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {data, response, error in
            if error != nil {
                
                completion (error)
                return
            }
         
              
         completion ( nil)
            }
        
        
        task.resume()
    }
  
   class func getStudentLocation (completion: @escaping ([StudentLocation]?, Error?) -> ()) {
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
   


