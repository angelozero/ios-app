//
//  FeedCategoriesResponse.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation

struct FeedCategoriesResponse: Decodable {
    let id: Int
    let name: String
    let products: [FeedProductsResponse]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case products = "products"
    }
}
