//
//  EndpointEnum.swift
//  KingBurguer
//
//  Created by angelo on 10/11/25.
//

import Foundation

enum EndpointEnum: String {
    case createUser = "/users"
    case login = "/auth/login"
    case refreshToken = "/auth/refresh-token"
    case feed = "/feed"
}
