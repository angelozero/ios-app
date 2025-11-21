//
//  FeedViewModel.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation


class FeedViewModel {
    
    private let feedInteractor: FeedInteractor
    
    init() {
        self.feedInteractor = FeedInteractor()
    }
    
    func fetchFeed(accessToken: String){
        
        feedInteractor.fetchFeed(accessToken: accessToken){ data, error in
            
            DispatchQueue.main.async {
                if let dataResponse = data {
                    print("FIM FEED")
                    print("TOTAL CATEGORIAS: \(dataResponse.categories.count)")
                    
                } else {

                    print("ERRO FIM FEED")
                }
            }
        }
    }
    
    func getUserAccessToken() -> String {
        return feedInteractor.getUserAccessToken()
    }
}
