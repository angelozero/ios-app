//
//  UserAuth.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation


struct UserAuth: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
}
