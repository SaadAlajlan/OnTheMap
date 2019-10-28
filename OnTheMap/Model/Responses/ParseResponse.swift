//
//  ParseResponse.swift
//  OnTheMap
//
//  Created by Saad on 10/25/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation

struct StudentLocation : Codable, Equatable {
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: Date
    let updatedAt: Date
    
    enum codingKeys: CodingKey{
           case objectId
             case uniqueKey
             case firstName
             case lastName
             case mapString
             case mediaURL
             case latitude
             case longitude
             case createdAt
             case updatedAt
    }
}

