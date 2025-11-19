//
//  FeedProductsResponse.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation

struct FeedProductsResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let pictureUrl: String
    let price: Double
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case pictureUrl = "picture_url"
        case price = "price"
        case createdDate = "created_date"
    }
}
