//
//  API.swift
//  OnTheMap
//
//  Created by Saad on 11/2/19.
//  Copyright © 2019 saad. All rights reserved.
//

import Foundation


class API{
    
    struct HeaderKeys{
        static let PARSE_APP_ID = "Content-Type"
        static let PARSE_APP_KEY = "Accept"
    }
    
    struct HeaderValues {
        
        static let PARSE_APP_ID = "application/json"
        static let PARSE_APP_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
    }
    
    struct ParamaterKeys {
        
        static let limit = MAIN + "StudentLocation?limit"
        static let skip = limit + "=200&skip=400"
        static let order = MAIN + "order"
        static let POST = "POST"
    }
    
    static let MAIN = "https://onthemap-api.udacity.com/v1/"
    static let SESSION = MAIN + "session"
    static let PUBLIC_USER = MAIN + "users"
    static let STUDENTS = MAIN + "StudentLocation"
}
