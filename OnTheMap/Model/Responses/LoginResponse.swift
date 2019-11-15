//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Saad on 11/15/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable{
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}

struct ClientError: Codable{
    let status: Int
    let error: String
}

extension ClientError: LocalizedError{
    var errorDescription: String? {
        return error
    }
}
