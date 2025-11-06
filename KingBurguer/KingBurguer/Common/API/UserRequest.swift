//
//  UserRequest.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

import Foundation

struct UserRequest: Codable {
    
    let name: String
    let password: String
    let email: String
    let document: String
    let birthday: String
    
}
