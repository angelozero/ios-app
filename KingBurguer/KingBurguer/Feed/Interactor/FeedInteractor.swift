//
//  FeedInteractor.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation

class FeedInteractor {
    
    private let remote: FeedRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetchFeed(accessToken: String, completion: @escaping (FeedResponse?, String?) -> Void){
        remote.fetchFeed(accessToken: accessToken) { fetchFeedResponse, error in
            if let fetchFeedResponse {
                completion(fetchFeedResponse, nil)
                
            } else {
                completion(nil, "SEM FEED RETORNADO")
            }
        }
    }
    
    func getUserAccessToken() -> String {
        return local.getUserAuth()?.accessToken ?? ""
    }
}
