//
//  SignUpUserNotAuthorized.swift
//  KingBurguer
//
//  Created by angelo on 12/11/25.
//

import Foundation

struct SignUpResponseNotAuthorized: Decodable {
    
    let detail: SignUpResponseDetail
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignUpResponseDetail: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
