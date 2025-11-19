//
//  FeedResponse.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation

struct FeedResponse: Decodable {
    let categories: [FeedCategoriesResponse]
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}
