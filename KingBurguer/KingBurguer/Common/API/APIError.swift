//
//  APIError.swift
//  KingBurguer
//
//  Created by angelo on 06/11/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case errorData(message: String)
    case invalidResponseStatus(Int)
}
