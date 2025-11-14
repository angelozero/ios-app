//
//  SignInResponseError.swift
//  KingBurguer
//
//  Created by angelo on 13/11/25.
//

import Foundation

struct SignInResponseErro: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
