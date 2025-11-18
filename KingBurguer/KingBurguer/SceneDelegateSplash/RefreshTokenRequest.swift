//
//  RefreshTokenRequest.swift
//  KingBurguer
//
//  Created by angelo on 17/11/25.
//

import Foundation

struct RefreshTokenRequest: Encodable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
