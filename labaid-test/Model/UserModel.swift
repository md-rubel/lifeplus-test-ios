//
//  UserModel.swift
//  labaid-test
//
//  Created by MD RUBEL on 21/1/21.
//

import Foundation

struct UserModel: Codable {
    let user: User
    let token: String
}

struct User: Codable {
    let id, name, email, phone: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phone
        case v = "__v"
    }
}
