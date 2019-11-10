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
    static let PARSE_APP_ID = "X-Parse-Application-Id"
    static let PARSE_APP_KEY = "X-Parse-REST-API-Key"
}

struct HeaderValues {
 
   static let PARSE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let PARSE_APP_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
}

struct ParamaterKeys {

    static let limit = MAIN + "StudentLocation?limit"
    static let skip = limit + "=200&skip=400"
    static let order = MAIN + "StudentLocation?order"
}

static let MAIN = "https://onthemap-api.udacity.com/v1/"
static let SESSION = MAIN + "session"
static let PUBLIC_USER = MAIN + "users"

}
