//
//  SignInRequest.swift
//  KingBurguer
//
//  Created by angelo on 13/11/25.
//

import Foundation

struct SignInRequest: Encodable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
