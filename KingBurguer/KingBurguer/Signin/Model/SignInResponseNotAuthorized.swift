//
//  SignInResponseNotAuthorized.swift
//  KingBurguer
//
//  Created by angelo on 13/11/25.
//

import Foundation

struct SignInResponseNotAuthorized: Decodable {
    let detail: SignInResponseDetail
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInResponseDetail: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

