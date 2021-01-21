//
//  SearchModel.swift
//  labaid-test
//
//  Created by MD RUBEL on 21/1/21.
//

import Foundation

struct SearchModel: Codable {
    let name, type, language: String
    let genres: [String]
    let premiered: String
    let image: Image
    let summary: String
}

struct Image: Codable {
    let medium: String
}
