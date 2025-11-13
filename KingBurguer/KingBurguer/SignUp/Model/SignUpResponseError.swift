//
//  SignUpResponseError.swift
//  KingBurguer
//
//  Created by angelo on 12/11/25.
//

import Foundation

struct SignUpResponseError: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
