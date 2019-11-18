//
//  userResponse.swift
//  OnTheMap
//
//  Created by Saad on 11/15/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation
struct AccountResponse: Codable {
    let user: UserInfo
}

struct UserInfo: Codable {
    let first_name: String
    let last_name: String
}
