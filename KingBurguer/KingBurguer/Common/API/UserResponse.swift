//
//  UserResponse.swift
//  KingBurguer
//
//  Created by angelo on 12/11/25.
//

import Foundation

struct UserResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case document
        case birthday
    }
}
