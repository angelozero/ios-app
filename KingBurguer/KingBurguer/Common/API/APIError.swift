//
//  APIError.swift
//  KingBurguer
//
//  Created by angelo on 06/11/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case invalidResponseStatus(Int)
}
