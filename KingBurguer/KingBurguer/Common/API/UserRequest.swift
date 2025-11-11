//
//  UserRequest.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

import Foundation

struct UserRequest: Encodable {
    
    let name: String
    let password: String
    let email: String
    let document: String
    let birthday: String
    
    
    // semelhante ao @JsonProperty do Spring
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case password = "password"
        case email = "email"
        case document = "document"
        case birthday = "birthday"
    }
    
}
