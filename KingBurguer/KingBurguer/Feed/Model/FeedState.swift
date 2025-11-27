//
//  FeedState.swift
//  KingBurguer
//
//  Created by angelo on 25/11/25.
//

import Foundation

enum FeedState {
    case loading
    case success(FeedResponse)
    case error(errorMessage: String)
}
