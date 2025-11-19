//
//  FeedRemoteDataSource.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation

class FeedRemoteDataSource {
    
    static let shared = FeedRemoteDataSource()
    
    func fetchFeed(accessToken: String, completion: @escaping (FeedResponse?, String?) -> Void){
        WebServiceAPI.shared.call(path: .feed, httpRequestType: .GET, accessToken: accessToken) { result in
            
            switch result {
            case .success(let data):
                if let dataValue = data {
                    let response = try? JSONDecoder().decode(FeedResponse.self, from: dataValue)
                    completion(response, nil)
                    break
                }
                break
            
            case .failure(let error, let data):
                guard let data else {
                    completion(nil, "SEM FEED")
                    break
                }
                completion(nil, "ERROR FEED")
                break

                
            }
        }
    }
}
