//
//  sessionRequest.swift
//  OnTheMap
//
//  Created by Saad on 11/15/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation


struct LoginSession: Codable {
    let udacity: SessionRequest
}

struct SessionRequest: Codable {
    let username: String
    let password: String
}
