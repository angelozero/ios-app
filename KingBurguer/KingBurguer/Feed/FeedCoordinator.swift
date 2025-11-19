//
//  FeedCoordinator.swift
//  KingBurguer
//
//  Created by angelo on 21/10/25.
//

import Foundation

class FeedCoordinator {
    
    private let feedViewModel: FeedViewModel
    
    init() {
        self.feedViewModel = FeedViewModel()
    }
    
    func fetchFeed(accesToken: String){
        feedViewModel.fetchFeed(accessToken: accesToken)
    }
    
    func getUserAccessToken() -> String {
        return feedViewModel.getUserAccessToken()
    }
}
