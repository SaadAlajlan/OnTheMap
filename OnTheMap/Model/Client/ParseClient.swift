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
    
    struct Auth {
          static var userPosted = StudentLocation(createdAt: "", firstName: "", lastName: "", latitude: 0, longitude: 0, mapString: "", mediaURL: "", objectId: "", uniqueKey: "", updatedAt: "")
          static var userList: [StudentLocation] = []
          static var sessionId: String = ""
          static var key = ""
      }
    
class func getLocations(url: URL, completion: @escaping (StudentLocations?, Error?) -> Void) {
        taskForGetRequest(url: url, responseType: StudentLocations.self) { (response, error) in
            if let response = response{
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            }
            else{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
    class func request(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        let loginSession = LoginSession(udacity: SessionRequest(username: username, password: password))
        
        taskForPostRequest(url: URL(string: API.SESSION)!, responseType: LoginResponse.self, body: loginSession) { (response, error) in
            if let response = response{
                Auth.sessionId = response.session.id
                Auth.key = response.account.key
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            }
            else{
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }
    }
    

    
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
//
            do{
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch{
                do{
                    let errorResponse = try JSONDecoder().decode(ClientError.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                }
                catch{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func postLocation(completion: @escaping (Bool, Error?) -> Void){
        let locationRequest = AddLocationRequest(uniqueKey: Auth.key, firstName: "Saad", lastName: "Alajlan", mapString: Auth.userPosted.mapString, mediaURL: Auth.userPosted.mediaURL, latitude: Auth.userPosted.latitude, longitude: Auth.userPosted.longitude)
        print("LocationData = \(Auth.userPosted)")
        let body = try? JSONEncoder().encode(locationRequest)
        
        var request = URLRequest(url: URL(string: API.STUDENTS)!)
        request.httpMethod = "POST"
        request.addValue(API.HeaderValues.PARSE_APP_ID, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_ID)
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            do{
                let resposeObject = try JSONDecoder().decode(AddLocationResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(true,nil)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }
        task.resume()
    }
    
    class func taskForPostRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
        let data = try? JSONEncoder().encode(body)
        guard let body = data else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = API.ParamaterKeys.POST
        request.addValue(API.HeaderValues.PARSE_APP_ID, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_KEY)
         request.addValue(API.HeaderValues.PARSE_APP_ID, forHTTPHeaderField: API.HeaderKeys.PARSE_APP_ID)
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { originalData, reponse, error in
            guard let originalData = originalData else{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let range = (5..<originalData.count)
            let data = originalData.subdata(in: range)
            let decoder = JSONDecoder()
            do{
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch{
                do{
                    let errorResponse = try JSONDecoder().decode(ClientError.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                }
                catch{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}
   


