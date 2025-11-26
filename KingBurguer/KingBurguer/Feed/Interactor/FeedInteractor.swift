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
    
    func fetchFeed(completion: @escaping (FeedResponse?, String?) -> Void){
        let userAuth = local.getUserAuth()
        
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access Token not found to feed service")
            return
        }

        remote.fetchFeed(accessToken: accessToken, completion: completion)
    }
}
