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
    
    
class func postSession(email: String, password : String, completion: @escaping(Bool, String, Error?) -> Void){
    var request = URLRequest(url: URL(string: API.SESSION)!)
              request.httpMethod = "POST"
              request.addValue("application/json", forHTTPHeaderField: "Accept")
              request.addValue("application.json", forHTTPHeaderField: "Content-Type")
                request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
              let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
                         if error != nil {
                            
                             completion (false, "", error)
                             return
                         }
                         
                         //Get the status code to check if the response is OK or not
                         guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                             
                          
                             let statusCodeError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
                             
                             completion (false, "", statusCodeError)
                             return
                         }
                         
                         
                         
                         if statusCode >= 200  && statusCode < 300 {
                             
                             //Skipping the first 5 characters
                             let range = 5..<data!.count
                             let newData = data?.subdata(in: range) /* subset response data! */
                             
                             //Print the data to see it and know you'll parse it (this can be removed after you complete building the app)
                             print (String(data: newData!, encoding: .utf8)!)
                             
                             //TODO: Get an object based on the received data in JSON format
                             let loginJsonObject = try! JSONSerialization.jsonObject(with: newData!, options: [])
                             
                             //TODO: Convert the object to a dictionary and call it loginDictionary
                             let loginDictionary = loginJsonObject as? [String : Any]
                             
                             //Get the unique key of the user
                             let accountDictionary = loginDictionary? ["account"] as? [String : Any]
                             let uniqueKey = accountDictionary? ["key"] as? String ?? " "
                             completion (true, uniqueKey, nil)
                         } else {
                             //TODO: call the completion handler properly
                             completion (false, "", nil)
                         }
                     }
                     //Start the task
                     task.resume()
    
          }
    
    class func deleteSession(completion: @escaping (Error?) -> Void){
        var request = URLRequest(url: URL(string: API.SESSION)!)
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



    class func PostStudentLocation (firstName: String, lastName: String,link: String, coordinate: CLLocationCoordinate2D, location: String, completion: @escaping ( Error?) -> ()) {
      var request = URLRequest (url: URL (string: API.MAIN + "StudentLocation")!)
       request.addValue(API.HeaderValues.PARSE_APP_ID, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_ID)
        request.addValue(API.HeaderValues.PARSE_APP_KEY, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_KEY)
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \(firstName)\", \"lastName\": \(lastName))\",\"mapString\": \"\(location)\", \"mediaURL\": \"\(link)\",\"latitude\": \(coordinate.latitude), \"longitude\": \(coordinate.longitude)}".data(using: .utf8)
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
    var request = URLRequest (url: URL (string: API.MAIN + "StudentLocation")!)
    
    request.addValue(API.HeaderValues.PARSE_APP_ID, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_ID)
           
           request.addValue(API.HeaderValues.PARSE_APP_KEY, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_KEY)
           
           let session = URLSession.shared
           let task = session.dataTask(with: request) {data, response, error in
               if error != nil {
                   
                   completion (nil, error)
                   return
               }
            
                   let studentsLocations = try! JSONDecoder().decode(StudentLocations.self, from: data!)
            stuedentsData.students = studentsLocations
            completion (studentsLocations.results, nil)
               }
           
           
           task.resume()
       }
}
   


