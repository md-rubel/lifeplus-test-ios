//
//  Links.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import Foundation

struct Links {
    
    public static let BASE_URL = "http://127.0.0.1:3000"
    
    public static let LOGIN = BASE_URL + "/users/login"
    public static let REGISTER = BASE_URL + "/users"
//    public static let GET_PROFILE = BASE_URL + "/users/me"
    public static let LOG_OUT = BASE_URL + "/users/logoutAll"
    
    public static let SEARCH = "http://api.tvmaze.com/singlesearch/shows"
}
