//
//  AddLocationRequest.swift
//  OnTheMap
//
//  Created by Saad on 11/16/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation



struct AddLocationRequest: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}
